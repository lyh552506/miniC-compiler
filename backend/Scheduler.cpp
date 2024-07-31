#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

// 依赖图类
class DependencyGraph {
private:
    unordered_map<string, vector<string>> adjList; // 邻接表
    unordered_map<string, int> inDegree; // 入度计数

public:
    // 添加节点
    void addNode(const string& nodeName) {
        if (adjList.find(nodeName) == adjList.end()) {
            adjList[nodeName] = vector<string>();
            inDegree[nodeName] = 0;
        }
    }

    // 添加依赖关系
    void addDependency(const string& dependentNodeName, const string& dependencyNodeName) {
        addNode(dependentNodeName);
        addNode(dependencyNodeName);
        adjList[dependentNodeName].push_back(dependencyNodeName);
        inDegree[dependentNodeName]++;
    }

    // 拓扑排序
    vector<string> topologicalSort() {
        queue<string> q;
        vector<string> sortedOrder;

        // 将所有入度为0的节点加入队列
        for (const auto& pair : inDegree) {
            if (pair.second == 0) {
                q.push(pair.first);
            }
        }

        while (!q.empty()) {
            string node = q.front();
            q.pop();
            sortedOrder.push_back(node);

            // 减少依赖此节点的所有节点的入度
            for (const string& neighbor : adjList[node]) {
                inDegree[neighbor]--;
                // 如果某个节点的入度变为0，将其加入队列
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        // 如果排序后的节点数量与总节点数量不一致，说明图中有环
        if (sortedOrder.size() != adjList.size()) {
            cout << "Error: Graph contains a cycle." << endl;
            return {};
        }

        return sortedOrder;
    }
};