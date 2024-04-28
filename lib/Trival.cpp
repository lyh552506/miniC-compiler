#include "Trival.hpp"

User* Trival::GenerateCallInst(std::string id,std::vector<Operand> args){
    auto check_builtin=[](std::string _id){
        if(_id=="getint")return true;
        if(_id=="getfloat")return true;
        if(_id=="getch")return true;
        if(_id=="getarray")return true;
        if(_id=="getfarray")return true;        
        if(_id=="putint")return true;
        if(_id=="putch")return true;
        if(_id=="putarray")return true;
        if(_id=="putfloat")return true;
        if(_id=="putfarray")return true;
        if(_id=="starttime")return true;
        if(_id=="stoptime")return true;
        if(_id=="putf")return true;
        if(_id=="llvm.memcpy.p0.p0.i32")return true;
        return false;
    };
    
    if(check_builtin(id)){
        if(id!="llvm.memcpy.p0.p0.i32")
            assert(0&&"Do not supported here");
        auto tmp=new CallInst(BuildInFunction::GetBuildInFunction(id),args,"");
        return tmp;
    }
    if(auto func=dynamic_cast<Function*>(Singleton<Module>().GetValueByName(id))){
        auto& params=func->GetParams();
        assert(args.size()==params.size());
        auto i=args.begin();
        for(auto j=params.begin();j!=params.end();j++,i++){
            auto& ii=*i;auto jj=j->get();
            if(jj->GetType()!=ii->GetType())
                assert(0&&"wrong input type");
        }
        auto inst=new CallInst(func,args,"");
        return inst;
    }
    else{
        std::cerr<<"No Such Function!\n";
        assert(0);
    }
}