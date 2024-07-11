#include "../include/lib/Trival.hpp"

bool Trival::check_builtin(std::string id){
    if(id=="getint")return true;
    if(id=="getfloat")return true;
    if(id=="getch")return true;
    if(id=="getarray")return true;
    if(id=="getfarray")return true;        
    if(id=="putint")return true;
    if(id=="putch")return true;
    if(id=="putarray")return true;
    if(id=="putfloat")return true;
    if(id=="putfarray")return true;
    if(id=="starttime")return true;
    if(id=="stoptime")return true;
    if(id=="putf")return true;
    if(id=="llvm.memcpy.p0.p0.i32")return true;
    return false;
}

User* Trival::GenerateCallInst(std::string id,std::vector<Operand> args){
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

CallInst* Trival::BuildInTransform(CallInst* inst){
    if(!check_builtin(inst->GetOperand(0)->GetName())){
        // std::cerr<<inst->GetOperand(0)->GetName()<<'\n';
        return inst;
    }
    if(inst->GetOperand(0)->GetName()=="llvm.memcpy.p0.p0.i32"){
        auto dst=inst->GetOperand(1);
        auto src=inst->GetOperand(2);
        auto size=inst->GetOperand(3);
        auto args=std::vector<Operand>();
        args.push_back(dst);
        args.push_back(src);
        args.push_back(size);
        auto tmp=new CallInst(BuildInFunction::GetBuildInFunction("memcpy@plt"),args,"");
        inst->FullReplace(tmp);
        delete inst;
        return tmp;
    }
    // std::cerr<<inst->GetOperand(0)->GetName()<<'\n';
    return inst;
}