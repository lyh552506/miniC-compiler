// A Bison parser, made by GNU Bison 3.8.2.

// Skeleton implementation for Bison LALR(1) parsers in C++

// Copyright (C) 2002-2015, 2018-2021 Free Software Foundation, Inc.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// As a special exception, you may create a larger work that contains
// part or all of the Bison parser skeleton and distribute that work
// under terms of your choice, so long as that work isn't itself a
// parser generator using the skeleton or a modified version thereof
// as a parser skeleton.  Alternatively, if you modify or redistribute
// the parser skeleton itself, you may (at your option) remove this
// special exception, which will cause the skeleton and the resulting
// Bison output files to be licensed under the GNU General Public
// License without this special exception.

// This special exception was added by the Free Software Foundation in
// version 2.2 of Bison.

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.





#include "parser.hpp"


// Unqualified %code blocks.
#line 9 "./parser.y"

extern yy::parser::symbol_type yylex();
namespace yy
{
  // Report an error to the user.
  auto parser::error (const std::string& msg) -> void
  {
    std::cerr << msg << '\n';
  }
}

#line 58 "parser.cpp"


#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> // FIXME: INFRINGES ON USER NAME SPACE.
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif


// Whether we are compiled with exception support.
#ifndef YY_EXCEPTIONS
# if defined __GNUC__ && !defined __EXCEPTIONS
#  define YY_EXCEPTIONS 0
# else
#  define YY_EXCEPTIONS 1
# endif
#endif



// Enable debugging if requested.
#if YYDEBUG

// A pseudo ostream that takes yydebug_ into account.
# define YYCDEBUG if (yydebug_) (*yycdebug_)

# define YY_SYMBOL_PRINT(Title, Symbol)         \
  do {                                          \
    if (yydebug_)                               \
    {                                           \
      *yycdebug_ << Title << ' ';               \
      yy_print_ (*yycdebug_, Symbol);           \
      *yycdebug_ << '\n';                       \
    }                                           \
  } while (false)

# define YY_REDUCE_PRINT(Rule)          \
  do {                                  \
    if (yydebug_)                       \
      yy_reduce_print_ (Rule);          \
  } while (false)

# define YY_STACK_PRINT()               \
  do {                                  \
    if (yydebug_)                       \
      yy_stack_print_ ();                \
  } while (false)

#else // !YYDEBUG

# define YYCDEBUG if (false) std::cerr
# define YY_SYMBOL_PRINT(Title, Symbol)  YY_USE (Symbol)
# define YY_REDUCE_PRINT(Rule)           static_cast<void> (0)
# define YY_STACK_PRINT()                static_cast<void> (0)

#endif // !YYDEBUG

#define yyerrok         (yyerrstatus_ = 0)
#define yyclearin       (yyla.clear ())

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYRECOVERING()  (!!yyerrstatus_)

namespace yy {
#line 131 "parser.cpp"

  /// Build a parser object.
  parser::parser ()
#if YYDEBUG
    : yydebug_ (false),
      yycdebug_ (&std::cerr)
#else

#endif
  {}

  parser::~parser ()
  {}

  parser::syntax_error::~syntax_error () YY_NOEXCEPT YY_NOTHROW
  {}

  /*---------.
  | symbol.  |
  `---------*/



  // by_state.
  parser::by_state::by_state () YY_NOEXCEPT
    : state (empty_state)
  {}

  parser::by_state::by_state (const by_state& that) YY_NOEXCEPT
    : state (that.state)
  {}

  void
  parser::by_state::clear () YY_NOEXCEPT
  {
    state = empty_state;
  }

  void
  parser::by_state::move (by_state& that)
  {
    state = that.state;
    that.clear ();
  }

  parser::by_state::by_state (state_type s) YY_NOEXCEPT
    : state (s)
  {}

  parser::symbol_kind_type
  parser::by_state::kind () const YY_NOEXCEPT
  {
    if (state == empty_state)
      return symbol_kind::S_YYEMPTY;
    else
      return YY_CAST (symbol_kind_type, yystos_[+state]);
  }

  parser::stack_symbol_type::stack_symbol_type ()
  {}

  parser::stack_symbol_type::stack_symbol_type (YY_RVREF (stack_symbol_type) that)
    : super_type (YY_MOVE (that.state))
  {
    switch (that.kind ())
    {
      case symbol_kind::S_Stmt: // Stmt
        value.YY_MOVE_OR_COPY< AST_NODE* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
        value.YY_MOVE_OR_COPY< AST_Type > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.YY_MOVE_OR_COPY< AddExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Block: // Block
        value.YY_MOVE_OR_COPY< Block* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BlockItem: // BlockItem
        value.YY_MOVE_OR_COPY< BlockItem* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.YY_MOVE_OR_COPY< BlockItems* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.YY_MOVE_OR_COPY< CallParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.YY_MOVE_OR_COPY< CompUnit* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.YY_MOVE_OR_COPY< ConstDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.YY_MOVE_OR_COPY< ConstDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.YY_MOVE_OR_COPY< ConstDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
        value.YY_MOVE_OR_COPY< Decl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.YY_MOVE_OR_COPY< EqExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.YY_MOVE_OR_COPY< Exps* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.YY_MOVE_OR_COPY< FuncDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.YY_MOVE_OR_COPY< FuncParam* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.YY_MOVE_OR_COPY< FuncParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.YY_MOVE_OR_COPY< InitVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.YY_MOVE_OR_COPY< InitVals* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.YY_MOVE_OR_COPY< LAndExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.YY_MOVE_OR_COPY< LOrExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LVal: // LVal
        value.YY_MOVE_OR_COPY< LVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.YY_MOVE_OR_COPY< MulExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.YY_MOVE_OR_COPY< PrimaryExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.YY_MOVE_OR_COPY< RelExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.YY_MOVE_OR_COPY< UnaryExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.YY_MOVE_OR_COPY< VarDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.YY_MOVE_OR_COPY< VarDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.YY_MOVE_OR_COPY< VarDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.YY_MOVE_OR_COPY< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.YY_MOVE_OR_COPY< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.YY_MOVE_OR_COPY< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

#if 201103L <= YY_CPLUSPLUS
    // that is emptied.
    that.state = empty_state;
#endif
  }

  parser::stack_symbol_type::stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) that)
    : super_type (s)
  {
    switch (that.kind ())
    {
      case symbol_kind::S_Stmt: // Stmt
        value.move< AST_NODE* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Type: // Type
        value.move< AST_Type > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.move< AddExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Block: // Block
        value.move< Block* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BlockItem: // BlockItem
        value.move< BlockItem* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.move< BlockItems* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.move< CallParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< CompUnit* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.move< ConstDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.move< ConstDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.move< ConstDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
        value.move< Decl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.move< EqExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< Exps* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< FuncDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.move< FuncParam* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.move< FuncParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.move< InitVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.move< InitVals* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.move< LAndExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.move< LOrExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LVal: // LVal
        value.move< LVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.move< MulExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.move< PrimaryExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.move< RelExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.move< UnaryExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.move< VarDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.move< VarDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.move< VarDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

    // that is emptied.
    that.kind_ = symbol_kind::S_YYEMPTY;
  }

#if YY_CPLUSPLUS < 201103L
  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (const stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_Stmt: // Stmt
        value.copy< AST_NODE* > (that.value);
        break;

      case symbol_kind::S_Type: // Type
        value.copy< AST_Type > (that.value);
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.copy< AddExp* > (that.value);
        break;

      case symbol_kind::S_Block: // Block
        value.copy< Block* > (that.value);
        break;

      case symbol_kind::S_BlockItem: // BlockItem
        value.copy< BlockItem* > (that.value);
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.copy< BlockItems* > (that.value);
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.copy< CallParams* > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.copy< CompUnit* > (that.value);
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.copy< ConstDecl* > (that.value);
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.copy< ConstDef* > (that.value);
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.copy< ConstDefs* > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
        value.copy< Decl* > (that.value);
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.copy< EqExp* > (that.value);
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.copy< Exps* > (that.value);
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.copy< FuncDef* > (that.value);
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.copy< FuncParam* > (that.value);
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.copy< FuncParams* > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.copy< InitVal* > (that.value);
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.copy< InitVals* > (that.value);
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.copy< LAndExp* > (that.value);
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.copy< LOrExp* > (that.value);
        break;

      case symbol_kind::S_LVal: // LVal
        value.copy< LVal* > (that.value);
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.copy< MulExp* > (that.value);
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.copy< PrimaryExp* > (that.value);
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.copy< RelExp* > (that.value);
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.copy< UnaryExp* > (that.value);
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.copy< VarDecl* > (that.value);
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.copy< VarDef* > (that.value);
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.copy< VarDefs* > (that.value);
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.copy< float > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.copy< int > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.copy< std::string > (that.value);
        break;

      default:
        break;
    }

    return *this;
  }

  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_Stmt: // Stmt
        value.move< AST_NODE* > (that.value);
        break;

      case symbol_kind::S_Type: // Type
        value.move< AST_Type > (that.value);
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.move< AddExp* > (that.value);
        break;

      case symbol_kind::S_Block: // Block
        value.move< Block* > (that.value);
        break;

      case symbol_kind::S_BlockItem: // BlockItem
        value.move< BlockItem* > (that.value);
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.move< BlockItems* > (that.value);
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.move< CallParams* > (that.value);
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< CompUnit* > (that.value);
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.move< ConstDecl* > (that.value);
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.move< ConstDef* > (that.value);
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.move< ConstDefs* > (that.value);
        break;

      case symbol_kind::S_Decl: // Decl
        value.move< Decl* > (that.value);
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.move< EqExp* > (that.value);
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< Exps* > (that.value);
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< FuncDef* > (that.value);
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.move< FuncParam* > (that.value);
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.move< FuncParams* > (that.value);
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.move< InitVal* > (that.value);
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.move< InitVals* > (that.value);
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.move< LAndExp* > (that.value);
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.move< LOrExp* > (that.value);
        break;

      case symbol_kind::S_LVal: // LVal
        value.move< LVal* > (that.value);
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.move< MulExp* > (that.value);
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.move< PrimaryExp* > (that.value);
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.move< RelExp* > (that.value);
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.move< UnaryExp* > (that.value);
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.move< VarDecl* > (that.value);
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.move< VarDef* > (that.value);
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.move< VarDefs* > (that.value);
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< float > (that.value);
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< int > (that.value);
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< std::string > (that.value);
        break;

      default:
        break;
    }

    // that is emptied.
    that.state = empty_state;
    return *this;
  }
#endif

  template <typename Base>
  void
  parser::yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const
  {
    if (yymsg)
      YY_SYMBOL_PRINT (yymsg, yysym);
  }

#if YYDEBUG
  template <typename Base>
  void
  parser::yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const
  {
    std::ostream& yyoutput = yyo;
    YY_USE (yyoutput);
    if (yysym.empty ())
      yyo << "empty symbol";
    else
      {
        symbol_kind_type yykind = yysym.kind ();
        yyo << (yykind < YYNTOKENS ? "token" : "nterm")
            << ' ' << yysym.name () << " (";
        YY_USE (yykind);
        yyo << ')';
      }
  }
#endif

  void
  parser::yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym)
  {
    if (m)
      YY_SYMBOL_PRINT (m, sym);
    yystack_.push (YY_MOVE (sym));
  }

  void
  parser::yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym)
  {
#if 201103L <= YY_CPLUSPLUS
    yypush_ (m, stack_symbol_type (s, std::move (sym)));
#else
    stack_symbol_type ss (s, sym);
    yypush_ (m, ss);
#endif
  }

  void
  parser::yypop_ (int n) YY_NOEXCEPT
  {
    yystack_.pop (n);
  }

#if YYDEBUG
  std::ostream&
  parser::debug_stream () const
  {
    return *yycdebug_;
  }

  void
  parser::set_debug_stream (std::ostream& o)
  {
    yycdebug_ = &o;
  }


  parser::debug_level_type
  parser::debug_level () const
  {
    return yydebug_;
  }

  void
  parser::set_debug_level (debug_level_type l)
  {
    yydebug_ = l;
  }
#endif // YYDEBUG

  parser::state_type
  parser::yy_lr_goto_state_ (state_type yystate, int yysym)
  {
    int yyr = yypgoto_[yysym - YYNTOKENS] + yystate;
    if (0 <= yyr && yyr <= yylast_ && yycheck_[yyr] == yystate)
      return yytable_[yyr];
    else
      return yydefgoto_[yysym - YYNTOKENS];
  }

  bool
  parser::yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yypact_ninf_;
  }

  bool
  parser::yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yytable_ninf_;
  }

  int
  parser::operator() ()
  {
    return parse ();
  }

  int
  parser::parse ()
  {
    int yyn;
    /// Length of the RHS of the rule being reduced.
    int yylen = 0;

    // Error handling.
    int yynerrs_ = 0;
    int yyerrstatus_ = 0;

    /// The lookahead symbol.
    symbol_type yyla;

    /// The return value of parse ().
    int yyresult;

#if YY_EXCEPTIONS
    try
#endif // YY_EXCEPTIONS
      {
    YYCDEBUG << "Starting parse\n";


    /* Initialize the stack.  The initial state will be set in
       yynewstate, since the latter expects the semantical and the
       location values to have been already stored, initialize these
       stacks with a primary value.  */
    yystack_.clear ();
    yypush_ (YY_NULLPTR, 0, YY_MOVE (yyla));

  /*-----------------------------------------------.
  | yynewstate -- push a new symbol on the stack.  |
  `-----------------------------------------------*/
  yynewstate:
    YYCDEBUG << "Entering state " << int (yystack_[0].state) << '\n';
    YY_STACK_PRINT ();

    // Accept?
    if (yystack_[0].state == yyfinal_)
      YYACCEPT;

    goto yybackup;


  /*-----------.
  | yybackup.  |
  `-----------*/
  yybackup:
    // Try to take a decision without lookahead.
    yyn = yypact_[+yystack_[0].state];
    if (yy_pact_value_is_default_ (yyn))
      goto yydefault;

    // Read a lookahead token.
    if (yyla.empty ())
      {
        YYCDEBUG << "Reading a token\n";
#if YY_EXCEPTIONS
        try
#endif // YY_EXCEPTIONS
          {
            symbol_type yylookahead (yylex ());
            yyla.move (yylookahead);
          }
#if YY_EXCEPTIONS
        catch (const syntax_error& yyexc)
          {
            YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
            error (yyexc);
            goto yyerrlab1;
          }
#endif // YY_EXCEPTIONS
      }
    YY_SYMBOL_PRINT ("Next token is", yyla);

    if (yyla.kind () == symbol_kind::S_YYerror)
    {
      // The scanner already issued an error message, process directly
      // to error recovery.  But do not keep the error token as
      // lookahead, it is too special and may lead us to an endless
      // loop in error recovery. */
      yyla.kind_ = symbol_kind::S_YYUNDEF;
      goto yyerrlab1;
    }

    /* If the proper action on seeing token YYLA.TYPE is to reduce or
       to detect an error, take that action.  */
    yyn += yyla.kind ();
    if (yyn < 0 || yylast_ < yyn || yycheck_[yyn] != yyla.kind ())
      {
        goto yydefault;
      }

    // Reduce or error.
    yyn = yytable_[yyn];
    if (yyn <= 0)
      {
        if (yy_table_value_is_error_ (yyn))
          goto yyerrlab;
        yyn = -yyn;
        goto yyreduce;
      }

    // Count tokens shifted since error; after three, turn off error status.
    if (yyerrstatus_)
      --yyerrstatus_;

    // Shift the lookahead token.
    yypush_ ("Shifting", state_type (yyn), YY_MOVE (yyla));
    goto yynewstate;


  /*-----------------------------------------------------------.
  | yydefault -- do the default action for the current state.  |
  `-----------------------------------------------------------*/
  yydefault:
    yyn = yydefact_[+yystack_[0].state];
    if (yyn == 0)
      goto yyerrlab;
    goto yyreduce;


  /*-----------------------------.
  | yyreduce -- do a reduction.  |
  `-----------------------------*/
  yyreduce:
    yylen = yyr2_[yyn];
    {
      stack_symbol_type yylhs;
      yylhs.state = yy_lr_goto_state_ (yystack_[yylen].state, yyr1_[yyn]);
      /* Variants are always initialized to an empty instance of the
         correct type. The default '$$ = $1' action is NOT applied
         when using variants.  */
      switch (yyr1_[yyn])
    {
      case symbol_kind::S_Stmt: // Stmt
        yylhs.value.emplace< AST_NODE* > ();
        break;

      case symbol_kind::S_Type: // Type
        yylhs.value.emplace< AST_Type > ();
        break;

      case symbol_kind::S_AddExp: // AddExp
        yylhs.value.emplace< AddExp* > ();
        break;

      case symbol_kind::S_Block: // Block
        yylhs.value.emplace< Block* > ();
        break;

      case symbol_kind::S_BlockItem: // BlockItem
        yylhs.value.emplace< BlockItem* > ();
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        yylhs.value.emplace< BlockItems* > ();
        break;

      case symbol_kind::S_CallParams: // CallParams
        yylhs.value.emplace< CallParams* > ();
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        yylhs.value.emplace< CompUnit* > ();
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        yylhs.value.emplace< ConstDecl* > ();
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        yylhs.value.emplace< ConstDef* > ();
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        yylhs.value.emplace< ConstDefs* > ();
        break;

      case symbol_kind::S_Decl: // Decl
        yylhs.value.emplace< Decl* > ();
        break;

      case symbol_kind::S_EqExp: // EqExp
        yylhs.value.emplace< EqExp* > ();
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        yylhs.value.emplace< Exps* > ();
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        yylhs.value.emplace< FuncDef* > ();
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        yylhs.value.emplace< FuncParam* > ();
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        yylhs.value.emplace< FuncParams* > ();
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        yylhs.value.emplace< InitVal* > ();
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        yylhs.value.emplace< InitVals* > ();
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        yylhs.value.emplace< LAndExp* > ();
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        yylhs.value.emplace< LOrExp* > ();
        break;

      case symbol_kind::S_LVal: // LVal
        yylhs.value.emplace< LVal* > ();
        break;

      case symbol_kind::S_MulExp: // MulExp
        yylhs.value.emplace< MulExp* > ();
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        yylhs.value.emplace< PrimaryExp* > ();
        break;

      case symbol_kind::S_RelExp: // RelExp
        yylhs.value.emplace< RelExp* > ();
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        yylhs.value.emplace< UnaryExp* > ();
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        yylhs.value.emplace< VarDecl* > ();
        break;

      case symbol_kind::S_VarDef: // VarDef
        yylhs.value.emplace< VarDef* > ();
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        yylhs.value.emplace< VarDefs* > ();
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        yylhs.value.emplace< float > ();
        break;

      case symbol_kind::S_num_INT: // num_INT
        yylhs.value.emplace< int > ();
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        yylhs.value.emplace< std::string > ();
        break;

      default:
        break;
    }



      // Perform the reduction.
      YY_REDUCE_PRINT (yyn);
#if YY_EXCEPTIONS
      try
#endif // YY_EXCEPTIONS
        {
          switch (yyn)
            {
  case 2: // GrammarEntrance: CompUnit
#line 114 "./parser.y"
                          {Singleton<CompUnit*>()=yystack_[0].value.as < CompUnit* > ();}
#line 1167 "parser.cpp"
    break;

  case 3: // CompUnit: Decl CompUnit
#line 116 "./parser.y"
                        {yylhs.value.as < CompUnit* > ()=yystack_[0].value.as < CompUnit* > ();yylhs.value.as < CompUnit* > ()->push_front((AST_NODE*)yystack_[1].value.as < Decl* > ());}
#line 1173 "parser.cpp"
    break;

  case 4: // CompUnit: FuncDef CompUnit
#line 117 "./parser.y"
                           {yylhs.value.as < CompUnit* > ()=yystack_[0].value.as < CompUnit* > ();yylhs.value.as < CompUnit* > ()->push_front((AST_NODE*)yystack_[1].value.as < FuncDef* > ());}
#line 1179 "parser.cpp"
    break;

  case 5: // CompUnit: Decl
#line 118 "./parser.y"
               {yylhs.value.as < CompUnit* > ()=new CompUnit((AST_NODE*)yystack_[0].value.as < Decl* > ());}
#line 1185 "parser.cpp"
    break;

  case 6: // CompUnit: FuncDef
#line 119 "./parser.y"
                  {{yylhs.value.as < CompUnit* > ()=new CompUnit((AST_NODE*)yystack_[0].value.as < FuncDef* > ());}}
#line 1191 "parser.cpp"
    break;

  case 7: // Decl: ConstDecl
#line 122 "./parser.y"
                {yylhs.value.as < Decl* > ()=new Decl(yystack_[0].value.as < ConstDecl* > ());}
#line 1197 "parser.cpp"
    break;

  case 8: // Decl: VarDecl
#line 123 "./parser.y"
              {yylhs.value.as < Decl* > ()=new Decl(yystack_[0].value.as < VarDecl* > ());}
#line 1203 "parser.cpp"
    break;

  case 9: // ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON
#line 126 "./parser.y"
                                              {yylhs.value.as < ConstDecl* > ()=new ConstDecl(yystack_[2].value.as < AST_Type > (),yystack_[1].value.as < ConstDefs* > ());}
#line 1209 "parser.cpp"
    break;

  case 10: // ConstDefs: ConstDefs Y_COMMA ConstDef
#line 129 "./parser.y"
                                      {yystack_[2].value.as < ConstDefs* > ()->push_back(yystack_[0].value.as < ConstDef* > ());}
#line 1215 "parser.cpp"
    break;

  case 11: // ConstDefs: ConstDef
#line 130 "./parser.y"
                    {yylhs.value.as < ConstDefs* > ()=new ConstDefs(yystack_[0].value.as < ConstDef* > ());}
#line 1221 "parser.cpp"
    break;

  case 12: // ConstDef: Y_ID Y_ASSIGN ConstInitVal
#line 133 "./parser.y"
                                     {yylhs.value.as < ConstDef* > ()=new ConstDef(yystack_[2].value.as < std::string > (),nullptr,yystack_[0].value.as < InitVal* > ());}
#line 1227 "parser.cpp"
    break;

  case 13: // ConstDef: Y_ID ConstExps Y_ASSIGN ConstInitVal
#line 134 "./parser.y"
                                               {yylhs.value.as < ConstDef* > ()=new ConstDef(yystack_[3].value.as < std::string > (),yystack_[2].value.as < Exps* > (),yystack_[0].value.as < InitVal* > ());}
#line 1233 "parser.cpp"
    break;

  case 14: // ConstExps: Y_LSQUARE AddExp Y_RSQUARE
#line 137 "./parser.y"
                                      {yylhs.value.as < Exps* > ()=new Exps(yystack_[1].value.as < AddExp* > ());}
#line 1239 "parser.cpp"
    break;

  case 15: // ConstExps: Y_LSQUARE AddExp Y_RSQUARE ConstExps
#line 138 "./parser.y"
                                                {yylhs.value.as < Exps* > ()=yystack_[0].value.as < Exps* > ();yylhs.value.as < Exps* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1245 "parser.cpp"
    break;

  case 16: // ConstInitVal: AddExp
#line 141 "./parser.y"
                     {yylhs.value.as < InitVal* > ()=new InitVal((AST_NODE*)yystack_[0].value.as < AddExp* > ());}
#line 1251 "parser.cpp"
    break;

  case 17: // ConstInitVal: Y_LBRACKET Y_RBRACKET
#line 142 "./parser.y"
                                    {yylhs.value.as < InitVal* > ()=new InitVal();}
#line 1257 "parser.cpp"
    break;

  case 18: // ConstInitVal: Y_LBRACKET ConstInitVals Y_RBRACKET
#line 143 "./parser.y"
                                                  {yylhs.value.as < InitVal* > ()=new InitVal((AST_NODE*)yystack_[1].value.as < InitVals* > ());}
#line 1263 "parser.cpp"
    break;

  case 19: // ConstInitVals: ConstInitVal
#line 146 "./parser.y"
                            {yylhs.value.as < InitVals* > ()=new InitVals(yystack_[0].value.as < InitVal* > ());}
#line 1269 "parser.cpp"
    break;

  case 20: // ConstInitVals: ConstInitVals Y_COMMA ConstInitVal
#line 147 "./parser.y"
                                                  {yylhs.value.as < InitVals* > ()=yystack_[2].value.as < InitVals* > ();yylhs.value.as < InitVals* > ()->push_back(yystack_[0].value.as < InitVal* > ());}
#line 1275 "parser.cpp"
    break;

  case 21: // VarDecl: Type VarDefs Y_SEMICOLON
#line 150 "./parser.y"
                                  {yylhs.value.as < VarDecl* > ()=new VarDecl(yystack_[2].value.as < AST_Type > (),yystack_[1].value.as < VarDefs* > ());}
#line 1281 "parser.cpp"
    break;

  case 22: // VarDefs: VarDef
#line 153 "./parser.y"
                {yylhs.value.as < VarDefs* > ()=new VarDefs(yystack_[0].value.as < VarDef* > ());}
#line 1287 "parser.cpp"
    break;

  case 23: // VarDefs: VarDefs Y_COMMA VarDef
#line 154 "./parser.y"
                                {yylhs.value.as < VarDefs* > ()=yystack_[2].value.as < VarDefs* > ();yylhs.value.as < VarDefs* > ()->push_back(yystack_[0].value.as < VarDef* > ());}
#line 1293 "parser.cpp"
    break;

  case 24: // VarDef: Y_ID
#line 157 "./parser.y"
             {yylhs.value.as < VarDef* > ()=new VarDef(yystack_[0].value.as < std::string > ());}
#line 1299 "parser.cpp"
    break;

  case 25: // VarDef: Y_ID Y_ASSIGN InitVal
#line 158 "./parser.y"
                              {yylhs.value.as < VarDef* > ()=new VarDef(yystack_[2].value.as < std::string > (),nullptr,yystack_[0].value.as < InitVal* > ());}
#line 1305 "parser.cpp"
    break;

  case 26: // VarDef: Y_ID ConstExps
#line 159 "./parser.y"
                       {yylhs.value.as < VarDef* > ()=new VarDef(yystack_[1].value.as < std::string > (),yystack_[0].value.as < Exps* > (),nullptr);}
#line 1311 "parser.cpp"
    break;

  case 27: // VarDef: Y_ID ConstExps Y_ASSIGN InitVal
#line 160 "./parser.y"
                                        {yylhs.value.as < VarDef* > ()=new VarDef(yystack_[3].value.as < std::string > (),yystack_[2].value.as < Exps* > (),yystack_[0].value.as < InitVal* > ());}
#line 1317 "parser.cpp"
    break;

  case 28: // InitVal: AddExp
#line 163 "./parser.y"
                {yylhs.value.as < InitVal* > ()=new InitVal((AST_NODE*)yystack_[0].value.as < AddExp* > ());}
#line 1323 "parser.cpp"
    break;

  case 29: // InitVal: Y_LBRACKET Y_RBRACKET
#line 164 "./parser.y"
                               {yylhs.value.as < InitVal* > ()=new InitVal(nullptr);}
#line 1329 "parser.cpp"
    break;

  case 30: // InitVal: Y_LBRACKET InitVals Y_RBRACKET
#line 165 "./parser.y"
                                        {yylhs.value.as < InitVal* > ()=new InitVal((AST_NODE*)yystack_[1].value.as < InitVals* > ());}
#line 1335 "parser.cpp"
    break;

  case 31: // InitVals: InitVal
#line 168 "./parser.y"
                  {yylhs.value.as < InitVals* > ()=new InitVals(yystack_[0].value.as < InitVal* > ());}
#line 1341 "parser.cpp"
    break;

  case 32: // InitVals: InitVals Y_COMMA InitVal
#line 169 "./parser.y"
                                   {yylhs.value.as < InitVals* > ()=yystack_[2].value.as < InitVals* > ();yylhs.value.as < InitVals* > ()->push_back(yystack_[0].value.as < InitVal* > ());}
#line 1347 "parser.cpp"
    break;

  case 33: // FuncDef: Type Y_ID Y_LPAR Y_RPAR Block
#line 172 "./parser.y"
                                       {yylhs.value.as < FuncDef* > ()=new FuncDef(yystack_[4].value.as < AST_Type > (),yystack_[3].value.as < std::string > (),nullptr,yystack_[0].value.as < Block* > ());}
#line 1353 "parser.cpp"
    break;

  case 34: // FuncDef: Type Y_ID Y_LPAR FuncParams Y_RPAR Block
#line 173 "./parser.y"
                                                  {yylhs.value.as < FuncDef* > ()=new FuncDef(yystack_[5].value.as < AST_Type > (),yystack_[4].value.as < std::string > (),yystack_[2].value.as < FuncParams* > (),yystack_[0].value.as < Block* > ());}
#line 1359 "parser.cpp"
    break;

  case 35: // FuncParams: FuncParam
#line 176 "./parser.y"
                      {yylhs.value.as < FuncParams* > ()=new FuncParams(yystack_[0].value.as < FuncParam* > ());}
#line 1365 "parser.cpp"
    break;

  case 36: // FuncParams: FuncParams Y_COMMA FuncParam
#line 177 "./parser.y"
                                         {yylhs.value.as < FuncParams* > ()=yystack_[2].value.as < FuncParams* > ();yylhs.value.as < FuncParams* > ()->push_back(yystack_[0].value.as < FuncParam* > ());}
#line 1371 "parser.cpp"
    break;

  case 37: // FuncParam: Type Y_ID
#line 180 "./parser.y"
                     {yylhs.value.as < FuncParam* > ()=new FuncParam(yystack_[1].value.as < AST_Type > (),yystack_[0].value.as < std::string > ());}
#line 1377 "parser.cpp"
    break;

  case 38: // FuncParam: Type Y_ID Y_LSQUARE Y_RSQUARE
#line 181 "./parser.y"
                                         {yylhs.value.as < FuncParam* > ()=new FuncParam(yystack_[3].value.as < AST_Type > (),yystack_[2].value.as < std::string > (),true);}
#line 1383 "parser.cpp"
    break;

  case 39: // FuncParam: Type Y_ID ArraySubscripts
#line 182 "./parser.y"
                                     {yylhs.value.as < FuncParam* > ()=new FuncParam(yystack_[2].value.as < AST_Type > (),yystack_[1].value.as < std::string > (),false,yystack_[0].value.as < Exps* > ());}
#line 1389 "parser.cpp"
    break;

  case 40: // FuncParam: Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts
#line 183 "./parser.y"
                                                         {yylhs.value.as < FuncParam* > ()=new FuncParam(yystack_[4].value.as < AST_Type > (),yystack_[3].value.as < std::string > (),true,yystack_[0].value.as < Exps* > ());}
#line 1395 "parser.cpp"
    break;

  case 41: // Block: Y_LBRACKET BlockItems Y_RBRACKET
#line 186 "./parser.y"
                                        {yylhs.value.as < Block* > ()=new Block(yystack_[1].value.as < BlockItems* > ());}
#line 1401 "parser.cpp"
    break;

  case 42: // Block: Y_LBRACKET Y_RBRACKET
#line 187 "./parser.y"
                             {yylhs.value.as < Block* > ()=new Block(nullptr);}
#line 1407 "parser.cpp"
    break;

  case 43: // BlockItems: BlockItem
#line 190 "./parser.y"
                      {yylhs.value.as < BlockItems* > ()=new BlockItems(yystack_[0].value.as < BlockItem* > ());}
#line 1413 "parser.cpp"
    break;

  case 44: // BlockItems: BlockItems BlockItem
#line 191 "./parser.y"
                                 {yylhs.value.as < BlockItems* > ()=yystack_[1].value.as < BlockItems* > ();yylhs.value.as < BlockItems* > ()->push_back(yystack_[0].value.as < BlockItem* > ());}
#line 1419 "parser.cpp"
    break;

  case 45: // BlockItem: Decl
#line 194 "./parser.y"
                {yylhs.value.as < BlockItem* > ()=new BlockItem((AST_NODE*)yystack_[0].value.as < Decl* > ());}
#line 1425 "parser.cpp"
    break;

  case 46: // BlockItem: Stmt
#line 195 "./parser.y"
                {yylhs.value.as < BlockItem* > ()=new BlockItem((AST_NODE*)yystack_[0].value.as < AST_NODE* > ());}
#line 1431 "parser.cpp"
    break;

  case 47: // Stmt: LVal Y_ASSIGN AddExp Y_SEMICOLON
#line 198 "./parser.y"
                                       {yylhs.value.as < AST_NODE* > ()=new AssignStmt(yystack_[3].value.as < LVal* > (),yystack_[1].value.as < AddExp* > ());}
#line 1437 "parser.cpp"
    break;

  case 48: // Stmt: Y_SEMICOLON
#line 199 "./parser.y"
                  {yylhs.value.as < AST_NODE* > ()=new ExpStmt(nullptr);}
#line 1443 "parser.cpp"
    break;

  case 49: // Stmt: AddExp Y_SEMICOLON
#line 200 "./parser.y"
                         {yylhs.value.as < AST_NODE* > ()=new ExpStmt(yystack_[1].value.as < AddExp* > ());}
#line 1449 "parser.cpp"
    break;

  case 50: // Stmt: Block
#line 201 "./parser.y"
            {yylhs.value.as < AST_NODE* > ()=yystack_[0].value.as < Block* > ();}
#line 1455 "parser.cpp"
    break;

  case 51: // Stmt: Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt
#line 202 "./parser.y"
                                        {yylhs.value.as < AST_NODE* > ()=new WhileStmt(yystack_[2].value.as < LOrExp* > (),yystack_[0].value.as < AST_NODE* > ());}
#line 1461 "parser.cpp"
    break;

  case 52: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt
#line 203 "./parser.y"
                                                 {yylhs.value.as < AST_NODE* > ()=new IfStmt(yystack_[4].value.as < LOrExp* > (),yystack_[2].value.as < AST_NODE* > (),yystack_[0].value.as < AST_NODE* > ());}
#line 1467 "parser.cpp"
    break;

  case 53: // Stmt: Y_IF Y_LPAR LOrExp Y_RPAR Stmt
#line 204 "./parser.y"
                                     {yylhs.value.as < AST_NODE* > ()=new IfStmt(yystack_[2].value.as < LOrExp* > (),yystack_[0].value.as < AST_NODE* > ());}
#line 1473 "parser.cpp"
    break;

  case 54: // Stmt: Y_BREAK Y_SEMICOLON
#line 205 "./parser.y"
                          {yylhs.value.as < AST_NODE* > ()=new BreakStmt();}
#line 1479 "parser.cpp"
    break;

  case 55: // Stmt: Y_CONTINUE Y_SEMICOLON
#line 206 "./parser.y"
                             {yylhs.value.as < AST_NODE* > ()=new ContinueStmt();}
#line 1485 "parser.cpp"
    break;

  case 56: // Stmt: Y_RETURN AddExp Y_SEMICOLON
#line 207 "./parser.y"
                                  {yylhs.value.as < AST_NODE* > ()=new ReturnStmt(yystack_[1].value.as < AddExp* > ());}
#line 1491 "parser.cpp"
    break;

  case 57: // Stmt: Y_RETURN Y_SEMICOLON
#line 208 "./parser.y"
                           {yylhs.value.as < AST_NODE* > ()=new ReturnStmt();}
#line 1497 "parser.cpp"
    break;

  case 58: // LVal: Y_ID
#line 211 "./parser.y"
           {yylhs.value.as < LVal* > ()=new LVal(yystack_[0].value.as < std::string > ());}
#line 1503 "parser.cpp"
    break;

  case 59: // LVal: Y_ID ArraySubscripts
#line 212 "./parser.y"
                           {yylhs.value.as < LVal* > ()=new LVal(yystack_[1].value.as < std::string > (),yystack_[0].value.as < Exps* > ());}
#line 1509 "parser.cpp"
    break;

  case 60: // ArraySubscripts: Y_LSQUARE AddExp Y_RSQUARE
#line 215 "./parser.y"
                                            {yylhs.value.as < Exps* > ()=new Exps(yystack_[1].value.as < AddExp* > ());}
#line 1515 "parser.cpp"
    break;

  case 61: // ArraySubscripts: Y_LSQUARE AddExp Y_RSQUARE ArraySubscripts
#line 216 "./parser.y"
                                                            {yylhs.value.as < Exps* > ()=yystack_[0].value.as < Exps* > ();yylhs.value.as < Exps* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1521 "parser.cpp"
    break;

  case 62: // PrimaryExp: Y_LPAR AddExp Y_RPAR
#line 219 "./parser.y"
                                 {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)yystack_[1].value.as < AddExp* > ());}
#line 1527 "parser.cpp"
    break;

  case 63: // PrimaryExp: LVal
#line 220 "./parser.y"
                 {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)yystack_[0].value.as < LVal* > ());}
#line 1533 "parser.cpp"
    break;

  case 64: // PrimaryExp: num_INT
#line 221 "./parser.y"
                    {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)(new ConstValue<int>(yystack_[0].value.as < int > ())));}
#line 1539 "parser.cpp"
    break;

  case 65: // PrimaryExp: num_FLOAT
#line 222 "./parser.y"
                      {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)(new ConstValue<float>(yystack_[0].value.as < float > ())));}
#line 1545 "parser.cpp"
    break;

  case 66: // PrimaryExp: Y_ID Y_LPAR Y_RPAR
#line 223 "./parser.y"
                               {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)(new FunctionCall(yystack_[2].value.as < std::string > ())));}
#line 1551 "parser.cpp"
    break;

  case 67: // PrimaryExp: Y_ID Y_LPAR CallParams Y_RPAR
#line 224 "./parser.y"
                                          {yylhs.value.as < PrimaryExp* > ()=new PrimaryExp((AST_NODE*)(new FunctionCall(yystack_[3].value.as < std::string > (),yystack_[1].value.as < CallParams* > ())));}
#line 1557 "parser.cpp"
    break;

  case 68: // UnaryExp: PrimaryExp
#line 227 "./parser.y"
                     {yylhs.value.as < UnaryExp* > ()=new UnaryExp(yystack_[0].value.as < PrimaryExp* > ());}
#line 1563 "parser.cpp"
    break;

  case 69: // UnaryExp: Y_ADD UnaryExp
#line 228 "./parser.y"
                         {yylhs.value.as < UnaryExp* > ()=yystack_[0].value.as < UnaryExp* > ();yylhs.value.as < UnaryExp* > ()->push_front(AST_ADD);}
#line 1569 "parser.cpp"
    break;

  case 70: // UnaryExp: Y_SUB UnaryExp
#line 229 "./parser.y"
                         {yylhs.value.as < UnaryExp* > ()=yystack_[0].value.as < UnaryExp* > ();yylhs.value.as < UnaryExp* > ()->push_front(AST_SUB);}
#line 1575 "parser.cpp"
    break;

  case 71: // UnaryExp: Y_NOT UnaryExp
#line 230 "./parser.y"
                         {yylhs.value.as < UnaryExp* > ()=yystack_[0].value.as < UnaryExp* > ();yylhs.value.as < UnaryExp* > ()->push_front(AST_NOT);}
#line 1581 "parser.cpp"
    break;

  case 72: // CallParams: AddExp
#line 233 "./parser.y"
                   {yylhs.value.as < CallParams* > ()=new CallParams(yystack_[0].value.as < AddExp* > ());}
#line 1587 "parser.cpp"
    break;

  case 73: // CallParams: AddExp Y_COMMA CallParams
#line 234 "./parser.y"
                                      {yylhs.value.as < CallParams* > ()=yystack_[0].value.as < CallParams* > ();yylhs.value.as < CallParams* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1593 "parser.cpp"
    break;

  case 74: // MulExp: UnaryExp
#line 237 "./parser.y"
                 {yylhs.value.as < MulExp* > ()=new MulExp(yystack_[0].value.as < UnaryExp* > ());}
#line 1599 "parser.cpp"
    break;

  case 75: // MulExp: MulExp Y_MUL UnaryExp
#line 238 "./parser.y"
                              {yylhs.value.as < MulExp* > ()=yystack_[2].value.as < MulExp* > ();yylhs.value.as < MulExp* > ()->push_back(AST_MUL);yylhs.value.as < MulExp* > ()->push_back(yystack_[0].value.as < UnaryExp* > ());}
#line 1605 "parser.cpp"
    break;

  case 76: // MulExp: MulExp Y_DIV UnaryExp
#line 239 "./parser.y"
                              {yylhs.value.as < MulExp* > ()=yystack_[2].value.as < MulExp* > ();yylhs.value.as < MulExp* > ()->push_back(AST_DIV);yylhs.value.as < MulExp* > ()->push_back(yystack_[0].value.as < UnaryExp* > ());}
#line 1611 "parser.cpp"
    break;

  case 77: // MulExp: MulExp Y_MODULO UnaryExp
#line 240 "./parser.y"
                                 {yylhs.value.as < MulExp* > ()=yystack_[2].value.as < MulExp* > ();yylhs.value.as < MulExp* > ()->push_back(AST_MODULO);yylhs.value.as < MulExp* > ()->push_back(yystack_[0].value.as < UnaryExp* > ());}
#line 1617 "parser.cpp"
    break;

  case 78: // AddExp: MulExp
#line 242 "./parser.y"
               {yylhs.value.as < AddExp* > ()=new AddExp(yystack_[0].value.as < MulExp* > ());}
#line 1623 "parser.cpp"
    break;

  case 79: // AddExp: AddExp Y_ADD MulExp
#line 243 "./parser.y"
                            {yylhs.value.as < AddExp* > ()=yystack_[2].value.as < AddExp* > ();yylhs.value.as < AddExp* > ()->push_back(AST_ADD);yylhs.value.as < AddExp* > ()->push_back(yystack_[0].value.as < MulExp* > ());}
#line 1629 "parser.cpp"
    break;

  case 80: // AddExp: AddExp Y_SUB MulExp
#line 244 "./parser.y"
                            {yylhs.value.as < AddExp* > ()=yystack_[2].value.as < AddExp* > ();yylhs.value.as < AddExp* > ()->push_back(AST_SUB);yylhs.value.as < AddExp* > ()->push_back(yystack_[0].value.as < MulExp* > ());}
#line 1635 "parser.cpp"
    break;

  case 81: // RelExp: AddExp
#line 246 "./parser.y"
               {yylhs.value.as < RelExp* > ()=new RelExp(yystack_[0].value.as < AddExp* > ());}
#line 1641 "parser.cpp"
    break;

  case 82: // RelExp: AddExp Y_LESS RelExp
#line 247 "./parser.y"
                             {yylhs.value.as < RelExp* > ()=yystack_[0].value.as < RelExp* > ();yylhs.value.as < RelExp* > ()->push_front(AST_LESS);yylhs.value.as < RelExp* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1647 "parser.cpp"
    break;

  case 83: // RelExp: AddExp Y_GREAT RelExp
#line 248 "./parser.y"
                              {yylhs.value.as < RelExp* > ()=yystack_[0].value.as < RelExp* > ();yylhs.value.as < RelExp* > ()->push_front(AST_GREAT);yylhs.value.as < RelExp* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1653 "parser.cpp"
    break;

  case 84: // RelExp: AddExp Y_LESSEQ RelExp
#line 249 "./parser.y"
                               {yylhs.value.as < RelExp* > ()=yystack_[0].value.as < RelExp* > ();yylhs.value.as < RelExp* > ()->push_front(AST_LESSEQ);yylhs.value.as < RelExp* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1659 "parser.cpp"
    break;

  case 85: // RelExp: AddExp Y_GREATEQ RelExp
#line 250 "./parser.y"
                                {yylhs.value.as < RelExp* > ()=yystack_[0].value.as < RelExp* > ();yylhs.value.as < RelExp* > ()->push_front(AST_GREATEQ);yylhs.value.as < RelExp* > ()->push_front(yystack_[2].value.as < AddExp* > ());}
#line 1665 "parser.cpp"
    break;

  case 86: // EqExp: RelExp
#line 252 "./parser.y"
              {yylhs.value.as < EqExp* > ()=new EqExp(yystack_[0].value.as < RelExp* > ());}
#line 1671 "parser.cpp"
    break;

  case 87: // EqExp: RelExp Y_EQ EqExp
#line 253 "./parser.y"
                         {yylhs.value.as < EqExp* > ()=yystack_[0].value.as < EqExp* > ();yylhs.value.as < EqExp* > ()->push_front(AST_EQ);yylhs.value.as < EqExp* > ()->push_front(yystack_[2].value.as < RelExp* > ());}
#line 1677 "parser.cpp"
    break;

  case 88: // EqExp: RelExp Y_NOTEQ EqExp
#line 254 "./parser.y"
                            {yylhs.value.as < EqExp* > ()=yystack_[0].value.as < EqExp* > ();yylhs.value.as < EqExp* > ()->push_front(AST_NOTEQ);yylhs.value.as < EqExp* > ()->push_front(yystack_[2].value.as < RelExp* > ());}
#line 1683 "parser.cpp"
    break;

  case 89: // LAndExp: EqExp
#line 256 "./parser.y"
               {yylhs.value.as < LAndExp* > ()=new LAndExp(yystack_[0].value.as < EqExp* > ());}
#line 1689 "parser.cpp"
    break;

  case 90: // LAndExp: EqExp Y_AND LAndExp
#line 257 "./parser.y"
                             {yylhs.value.as < LAndExp* > ()=yystack_[0].value.as < LAndExp* > ();yylhs.value.as < LAndExp* > ()->push_front(AST_AND);yylhs.value.as < LAndExp* > ()->push_front(yystack_[2].value.as < EqExp* > ());}
#line 1695 "parser.cpp"
    break;

  case 91: // LOrExp: LAndExp
#line 259 "./parser.y"
                {yylhs.value.as < LOrExp* > ()=new LOrExp(yystack_[0].value.as < LAndExp* > ());}
#line 1701 "parser.cpp"
    break;

  case 92: // LOrExp: LAndExp Y_OR LOrExp
#line 260 "./parser.y"
                            {yylhs.value.as < LOrExp* > ()=yystack_[0].value.as < LOrExp* > ();yylhs.value.as < LOrExp* > ()->push_front(AST_OR);yylhs.value.as < LOrExp* > ()->push_front(yystack_[2].value.as < LAndExp* > ());}
#line 1707 "parser.cpp"
    break;

  case 93: // Type: Y_INT
#line 262 "./parser.y"
            {yylhs.value.as < AST_Type > ()=AST_INT;}
#line 1713 "parser.cpp"
    break;

  case 94: // Type: Y_FLOAT
#line 263 "./parser.y"
              {yylhs.value.as < AST_Type > ()=AST_FLOAT;}
#line 1719 "parser.cpp"
    break;

  case 95: // Type: Y_VOID
#line 264 "./parser.y"
             {yylhs.value.as < AST_Type > ()=AST_VOID;}
#line 1725 "parser.cpp"
    break;


#line 1729 "parser.cpp"

            default:
              break;
            }
        }
#if YY_EXCEPTIONS
      catch (const syntax_error& yyexc)
        {
          YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
          error (yyexc);
          YYERROR;
        }
#endif // YY_EXCEPTIONS
      YY_SYMBOL_PRINT ("-> $$ =", yylhs);
      yypop_ (yylen);
      yylen = 0;

      // Shift the result of the reduction.
      yypush_ (YY_NULLPTR, YY_MOVE (yylhs));
    }
    goto yynewstate;


  /*--------------------------------------.
  | yyerrlab -- here on detecting error.  |
  `--------------------------------------*/
  yyerrlab:
    // If not already recovering from an error, report this error.
    if (!yyerrstatus_)
      {
        ++yynerrs_;
        std::string msg = YY_("syntax error");
        error (YY_MOVE (msg));
      }


    if (yyerrstatus_ == 3)
      {
        /* If just tried and failed to reuse lookahead token after an
           error, discard it.  */

        // Return failure if at end of input.
        if (yyla.kind () == symbol_kind::S_YYEOF)
          YYABORT;
        else if (!yyla.empty ())
          {
            yy_destroy_ ("Error: discarding", yyla);
            yyla.clear ();
          }
      }

    // Else will try to reuse lookahead token after shifting the error token.
    goto yyerrlab1;


  /*---------------------------------------------------.
  | yyerrorlab -- error raised explicitly by YYERROR.  |
  `---------------------------------------------------*/
  yyerrorlab:
    /* Pacify compilers when the user code never invokes YYERROR and
       the label yyerrorlab therefore never appears in user code.  */
    if (false)
      YYERROR;

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYERROR.  */
    yypop_ (yylen);
    yylen = 0;
    YY_STACK_PRINT ();
    goto yyerrlab1;


  /*-------------------------------------------------------------.
  | yyerrlab1 -- common code for both syntax error and YYERROR.  |
  `-------------------------------------------------------------*/
  yyerrlab1:
    yyerrstatus_ = 3;   // Each real token shifted decrements this.
    // Pop stack until we find a state that shifts the error token.
    for (;;)
      {
        yyn = yypact_[+yystack_[0].state];
        if (!yy_pact_value_is_default_ (yyn))
          {
            yyn += symbol_kind::S_YYerror;
            if (0 <= yyn && yyn <= yylast_
                && yycheck_[yyn] == symbol_kind::S_YYerror)
              {
                yyn = yytable_[yyn];
                if (0 < yyn)
                  break;
              }
          }

        // Pop the current state because it cannot handle the error token.
        if (yystack_.size () == 1)
          YYABORT;

        yy_destroy_ ("Error: popping", yystack_[0]);
        yypop_ ();
        YY_STACK_PRINT ();
      }
    {
      stack_symbol_type error_token;


      // Shift the error token.
      error_token.state = state_type (yyn);
      yypush_ ("Shifting", YY_MOVE (error_token));
    }
    goto yynewstate;


  /*-------------------------------------.
  | yyacceptlab -- YYACCEPT comes here.  |
  `-------------------------------------*/
  yyacceptlab:
    yyresult = 0;
    goto yyreturn;


  /*-----------------------------------.
  | yyabortlab -- YYABORT comes here.  |
  `-----------------------------------*/
  yyabortlab:
    yyresult = 1;
    goto yyreturn;


  /*-----------------------------------------------------.
  | yyreturn -- parsing is finished, return the result.  |
  `-----------------------------------------------------*/
  yyreturn:
    if (!yyla.empty ())
      yy_destroy_ ("Cleanup: discarding lookahead", yyla);

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYABORT or YYACCEPT.  */
    yypop_ (yylen);
    YY_STACK_PRINT ();
    while (1 < yystack_.size ())
      {
        yy_destroy_ ("Cleanup: popping", yystack_[0]);
        yypop_ ();
      }

    return yyresult;
  }
#if YY_EXCEPTIONS
    catch (...)
      {
        YYCDEBUG << "Exception caught: cleaning lookahead and stack\n";
        // Do not try to display the values of the reclaimed symbols,
        // as their printers might throw an exception.
        if (!yyla.empty ())
          yy_destroy_ (YY_NULLPTR, yyla);

        while (1 < yystack_.size ())
          {
            yy_destroy_ (YY_NULLPTR, yystack_[0]);
            yypop_ ();
          }
        throw;
      }
#endif // YY_EXCEPTIONS
  }

  void
  parser::error (const syntax_error& yyexc)
  {
    error (yyexc.what ());
  }

#if YYDEBUG || 0
  const char *
  parser::symbol_name (symbol_kind_type yysymbol)
  {
    return yytname_[yysymbol];
  }
#endif // #if YYDEBUG || 0









  const signed char parser::yypact_ninf_ = -121;

  const signed char parser::yytable_ninf_ = -1;

  const short
  parser::yypact_[] =
  {
     122,  -121,  -121,  -121,   126,    12,  -121,   122,  -121,  -121,
     122,    64,    92,  -121,  -121,  -121,    29,    53,  -121,    40,
     139,  -121,   208,    22,   245,    38,  -121,    95,   213,    60,
    -121,    92,    15,  -121,  -121,   245,   245,   245,   245,    66,
    -121,  -121,  -121,  -121,   121,   187,    -7,    57,  -121,   104,
      51,   208,    73,  -121,   184,  -121,   187,   213,  -121,   240,
     245,  -121,  -121,  -121,  -121,     2,  -121,  -121,    98,   245,
     245,   245,   245,   245,   107,  -121,    -7,   126,   120,   131,
    -121,  -121,  -121,   127,  -121,  -121,   105,    -2,    59,  -121,
    -121,   208,  -121,  -121,  -121,   121,   121,   133,   153,   175,
     179,   135,  -121,  -121,  -121,  -121,   143,  -121,  -121,   182,
      14,    95,  -121,  -121,   218,  -121,  -121,  -121,   213,  -121,
     245,   204,  -121,  -121,   245,   245,  -121,    28,  -121,  -121,
    -121,   245,  -121,   204,  -121,  -121,  -121,   145,   148,   209,
     210,   215,   219,  -121,    33,  -121,   245,   245,   245,   245,
     245,   245,   245,   245,   174,   174,  -121,  -121,  -121,  -121,
    -121,  -121,  -121,  -121,  -121,  -121,   232,   174,  -121
  };

  const signed char
  parser::yydefact_[] =
  {
       0,    93,    94,    95,     0,     0,     2,     5,     7,     8,
       6,     0,     0,     1,     3,     4,    24,     0,    22,     0,
       0,    11,     0,     0,     0,    26,    21,     0,     0,     0,
       9,     0,    58,    65,    64,     0,     0,     0,     0,     0,
      25,    63,    68,    74,    78,    28,     0,     0,    35,     0,
       0,     0,    24,    23,     0,    12,    16,     0,    10,     0,
       0,    59,    69,    70,    71,     0,    29,    31,     0,     0,
       0,     0,     0,     0,     0,    33,     0,     0,    37,    14,
      27,    17,    19,     0,    13,    66,     0,    72,     0,    62,
      30,     0,    75,    77,    76,    79,    80,     0,     0,     0,
       0,     0,    42,    48,    45,    50,     0,    43,    46,    63,
       0,     0,    34,    36,     0,    39,    15,    18,     0,    67,
       0,    60,    32,    54,     0,     0,    57,     0,    55,    41,
      44,     0,    49,    38,    20,    73,    61,    81,    86,    89,
      91,     0,     0,    56,     0,    40,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    47,    83,    85,    82,
      84,    87,    88,    90,    92,    51,    53,     0,    52
  };

  const short
  parser::yypgoto_[] =
  {
    -121,  -121,    97,   -64,  -121,  -121,   214,   -16,   -46,  -121,
    -121,  -121,   223,   -30,  -121,  -121,  -121,   190,   -33,  -121,
     163,  -114,   -67,   -74,  -121,   -13,   150,   141,   -22,   117,
      67,   123,  -120,    -3
  };

  const unsigned char
  parser::yydefgoto_[] =
  {
       0,     5,     6,     7,     8,    20,    21,    25,    55,    83,
       9,    17,    18,    40,    68,    10,    47,    48,   105,   106,
     107,   108,    41,    61,    42,    43,    86,    44,   137,   138,
     139,   140,   141,    11
  };

  const unsigned char
  parser::yytable_[] =
  {
      45,    12,    50,    29,   115,   142,    56,   109,    82,    67,
     104,    84,    13,    75,    72,    73,    65,    45,    72,    73,
      49,    80,    62,    63,    64,     1,     2,     3,    74,    45,
      72,    73,    56,   164,    89,    56,   120,    87,    88,   109,
     165,   166,   104,   112,    72,    73,    59,   136,    60,    72,
      73,   132,   110,   168,    46,    22,    92,    93,    94,   145,
      23,   122,    24,   116,    51,   143,    28,    72,    73,    45,
     156,   111,   134,    24,    49,    72,    73,    16,   127,    32,
      33,    34,    35,    36,   110,    79,    57,   109,   109,    76,
      26,    27,    88,   121,    37,    77,    56,    38,    87,    22,
     109,    39,    66,   111,    14,    19,    24,    15,    52,   144,
       1,     2,     3,     4,    97,    98,    99,    78,   100,   101,
      32,    33,    34,    35,    36,     1,     2,     3,     4,     1,
       2,     3,   110,   110,    90,    37,    91,   119,    38,    69,
      70,    71,    74,   102,   103,   110,     1,     2,     3,     4,
      97,    98,    99,   114,   100,   101,    32,    33,    34,    35,
      36,    72,    73,   117,    24,   118,   146,   147,   148,   149,
     123,    37,   128,   150,    38,   151,    30,    31,    74,   129,
     103,    97,    98,    99,   124,   100,   101,    32,    33,    34,
      35,    36,    32,    33,    34,    35,    36,    32,    33,    34,
      35,    36,    37,    72,    73,    38,   125,    37,   131,    74,
      38,   103,    37,    95,    96,    38,   126,   161,   162,    54,
      81,    32,    33,    34,    35,    36,    32,    33,    34,    35,
      36,    32,    33,    34,    35,    36,    37,    60,   152,    38,
     153,    37,   167,    39,    38,    58,    37,   154,    54,    38,
      53,   155,   133,    32,    33,    34,    35,    36,    32,    33,
      34,    35,    36,   157,   158,   159,   160,   113,    37,   130,
     135,    38,    85,    37,     0,   163,    38
  };

  const short
  parser::yycheck_[] =
  {
      22,     4,    24,    19,    78,   125,    28,    74,    54,    39,
      74,    57,     0,    46,    16,    17,    38,    39,    16,    17,
      23,    51,    35,    36,    37,     3,     4,     5,    35,    51,
      16,    17,    54,   153,    32,    57,    38,    59,    60,   106,
     154,   155,   106,    76,    16,    17,    31,   121,    33,    16,
      17,    37,    74,   167,    32,    26,    69,    70,    71,   133,
      31,    91,    33,    79,    26,    37,    26,    16,    17,    91,
      37,    74,   118,    33,    77,    16,    17,    13,   100,    13,
      14,    15,    16,    17,   106,    34,    26,   154,   155,    32,
      37,    38,   114,    34,    28,    38,   118,    31,   120,    26,
     167,    35,    36,   106,     7,    13,    33,    10,    13,   131,
       3,     4,     5,     6,     7,     8,     9,    13,    11,    12,
      13,    14,    15,    16,    17,     3,     4,     5,     6,     3,
       4,     5,   154,   155,    36,    28,    38,    32,    31,    18,
      19,    20,    35,    36,    37,   167,     3,     4,     5,     6,
       7,     8,     9,    33,    11,    12,    13,    14,    15,    16,
      17,    16,    17,    36,    33,    38,    21,    22,    23,    24,
      37,    28,    37,    25,    31,    27,    37,    38,    35,    36,
      37,     7,     8,     9,    31,    11,    12,    13,    14,    15,
      16,    17,    13,    14,    15,    16,    17,    13,    14,    15,
      16,    17,    28,    16,    17,    31,    31,    28,    26,    35,
      31,    37,    28,    72,    73,    31,    37,   150,   151,    35,
      36,    13,    14,    15,    16,    17,    13,    14,    15,    16,
      17,    13,    14,    15,    16,    17,    28,    33,    29,    31,
      30,    28,    10,    35,    31,    31,    28,    32,    35,    31,
      27,    32,    34,    13,    14,    15,    16,    17,    13,    14,
      15,    16,    17,   146,   147,   148,   149,    77,    28,   106,
     120,    31,    32,    28,    -1,   152,    31
  };

  const signed char
  parser::yystos_[] =
  {
       0,     3,     4,     5,     6,    40,    41,    42,    43,    49,
      54,    72,    72,     0,    41,    41,    13,    50,    51,    13,
      44,    45,    26,    31,    33,    46,    37,    38,    26,    46,
      37,    38,    13,    14,    15,    16,    17,    28,    31,    35,
      52,    61,    63,    64,    66,    67,    32,    55,    56,    72,
      67,    26,    13,    51,    35,    47,    67,    26,    45,    31,
      33,    62,    64,    64,    64,    67,    36,    52,    53,    18,
      19,    20,    16,    17,    35,    57,    32,    38,    13,    34,
      52,    36,    47,    48,    47,    32,    65,    67,    67,    32,
      36,    38,    64,    64,    64,    66,    66,     7,     8,     9,
      11,    12,    36,    37,    42,    57,    58,    59,    60,    61,
      67,    72,    57,    56,    33,    62,    46,    36,    38,    32,
      38,    34,    52,    37,    31,    31,    37,    67,    37,    36,
      59,    26,    37,    34,    47,    65,    62,    67,    68,    69,
      70,    71,    71,    37,    67,    62,    21,    22,    23,    24,
      25,    27,    29,    30,    32,    32,    37,    68,    68,    68,
      68,    69,    69,    70,    71,    60,    60,    10,    60
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    39,    40,    41,    41,    41,    41,    42,    42,    43,
      44,    44,    45,    45,    46,    46,    47,    47,    47,    48,
      48,    49,    50,    50,    51,    51,    51,    51,    52,    52,
      52,    53,    53,    54,    54,    55,    55,    56,    56,    56,
      56,    57,    57,    58,    58,    59,    59,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    61,    61,
      62,    62,    63,    63,    63,    63,    63,    63,    64,    64,
      64,    64,    65,    65,    66,    66,    66,    66,    67,    67,
      67,    68,    68,    68,    68,    68,    69,    69,    69,    70,
      70,    71,    71,    72,    72,    72
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     2,     1,     1,     1,     1,     4,
       3,     1,     3,     4,     3,     4,     1,     2,     3,     1,
       3,     3,     1,     3,     1,     3,     2,     4,     1,     2,
       3,     1,     3,     5,     6,     1,     3,     2,     4,     3,
       5,     3,     2,     1,     2,     1,     1,     4,     1,     2,
       1,     5,     7,     5,     2,     2,     3,     2,     1,     2,
       3,     4,     3,     1,     1,     1,     3,     4,     1,     2,
       2,     2,     1,     3,     1,     3,     3,     3,     1,     3,
       3,     1,     3,     3,     3,     3,     1,     3,     3,     1,
       3,     1,     3,     1,     1,     1
  };


#if YYDEBUG
  // YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
  // First, the terminals, then, starting at \a YYNTOKENS, nonterminals.
  const char*
  const parser::yytname_[] =
  {
  "\"end of file\"", "error", "\"invalid token\"", "Y_INT", "Y_FLOAT",
  "Y_VOID", "Y_CONST", "Y_BREAK", "Y_WHILE", "Y_IF", "Y_ELSE", "Y_RETURN",
  "Y_CONTINUE", "Y_ID", "num_FLOAT", "num_INT", "Y_ADD", "Y_SUB", "Y_MUL",
  "Y_MODULO", "Y_DIV", "Y_GREAT", "Y_GREATEQ", "Y_LESS", "Y_LESSEQ",
  "Y_EQ", "Y_ASSIGN", "Y_NOTEQ", "Y_NOT", "Y_AND", "Y_OR", "Y_LPAR",
  "Y_RPAR", "Y_LSQUARE", "Y_RSQUARE", "Y_LBRACKET", "Y_RBRACKET",
  "Y_SEMICOLON", "Y_COMMA", "$accept", "GrammarEntrance", "CompUnit",
  "Decl", "ConstDecl", "ConstDefs", "ConstDef", "ConstExps",
  "ConstInitVal", "ConstInitVals", "VarDecl", "VarDefs", "VarDef",
  "InitVal", "InitVals", "FuncDef", "FuncParams", "FuncParam", "Block",
  "BlockItems", "BlockItem", "Stmt", "LVal", "ArraySubscripts",
  "PrimaryExp", "UnaryExp", "CallParams", "MulExp", "AddExp", "RelExp",
  "EqExp", "LAndExp", "LOrExp", "Type", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const short
  parser::yyrline_[] =
  {
       0,   114,   114,   116,   117,   118,   119,   122,   123,   126,
     129,   130,   133,   134,   137,   138,   141,   142,   143,   146,
     147,   150,   153,   154,   157,   158,   159,   160,   163,   164,
     165,   168,   169,   172,   173,   176,   177,   180,   181,   182,
     183,   186,   187,   190,   191,   194,   195,   198,   199,   200,
     201,   202,   203,   204,   205,   206,   207,   208,   211,   212,
     215,   216,   219,   220,   221,   222,   223,   224,   227,   228,
     229,   230,   233,   234,   237,   238,   239,   240,   242,   243,
     244,   246,   247,   248,   249,   250,   252,   253,   254,   256,
     257,   259,   260,   262,   263,   264
  };

  void
  parser::yy_stack_print_ () const
  {
    *yycdebug_ << "Stack now";
    for (stack_type::const_iterator
           i = yystack_.begin (),
           i_end = yystack_.end ();
         i != i_end; ++i)
      *yycdebug_ << ' ' << int (i->state);
    *yycdebug_ << '\n';
  }

  void
  parser::yy_reduce_print_ (int yyrule) const
  {
    int yylno = yyrline_[yyrule];
    int yynrhs = yyr2_[yyrule];
    // Print the symbols being reduced, and their result.
    *yycdebug_ << "Reducing stack by rule " << yyrule - 1
               << " (line " << yylno << "):\n";
    // The symbols being reduced.
    for (int yyi = 0; yyi < yynrhs; yyi++)
      YY_SYMBOL_PRINT ("   $" << yyi + 1 << " =",
                       yystack_[(yynrhs) - (yyi + 1)]);
  }
#endif // YYDEBUG


} // yy
#line 2171 "parser.cpp"

#line 266 "./parser.y"

