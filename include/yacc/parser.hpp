// A Bison parser, made by GNU Bison 3.8.2.

// Skeleton interface for Bison LALR(1) parsers in C++

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


/**
 ** \file parser.hpp
 ** Define the yy::parser class.
 */

// C++ LALR(1) parser skeleton written by Akim Demaille.

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.

#ifndef YY_YY_PARSER_HPP_INCLUDED
# define YY_YY_PARSER_HPP_INCLUDED
// "%code requires" blocks.
#line 4 "parser.y"

#include "../../include/lib/AST_NODE.hpp"
#include "../../include/lib/Singleton.hpp"

#line 54 "parser.hpp"


# include <cstdlib> // std::abort
# include <iostream>
# include <stdexcept>
# include <string>
# include <vector>

#if defined __cplusplus
# define YY_CPLUSPLUS __cplusplus
#else
# define YY_CPLUSPLUS 199711L
#endif

// Support move semantics when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_MOVE           std::move
# define YY_MOVE_OR_COPY   move
# define YY_MOVE_REF(Type) Type&&
# define YY_RVREF(Type)    Type&&
# define YY_COPY(Type)     Type
#else
# define YY_MOVE
# define YY_MOVE_OR_COPY   copy
# define YY_MOVE_REF(Type) Type&
# define YY_RVREF(Type)    const Type&
# define YY_COPY(Type)     const Type&
#endif

// Support noexcept when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_NOEXCEPT noexcept
# define YY_NOTHROW
#else
# define YY_NOEXCEPT
# define YY_NOTHROW throw ()
#endif

// Support constexpr when possible.
#if 201703 <= YY_CPLUSPLUS
# define YY_CONSTEXPR constexpr
#else
# define YY_CONSTEXPR
#endif



#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

namespace yy {
#line 189 "parser.hpp"




  /// A Bison parser.
  class parser
  {
  public:
#ifdef YYSTYPE
# ifdef __GNUC__
#  pragma GCC message "bison: do not #define YYSTYPE in C++, use %define api.value.type"
# endif
    typedef YYSTYPE value_type;
#else
  /// A buffer to store and retrieve objects.
  ///
  /// Sort of a variant, but does not keep track of the nature
  /// of the stored data, since that knowledge is available
  /// via the current parser state.
  class value_type
  {
  public:
    /// Type of *this.
    typedef value_type self_type;

    /// Empty construction.
    value_type () YY_NOEXCEPT
      : yyraw_ ()
    {}

    /// Construct and fill.
    template <typename T>
    value_type (YY_RVREF (T) t)
    {
      new (yyas_<T> ()) T (YY_MOVE (t));
    }

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    value_type (const self_type&) = delete;
    /// Non copyable.
    self_type& operator= (const self_type&) = delete;
#endif

    /// Destruction, allowed only if empty.
    ~value_type () YY_NOEXCEPT
    {}

# if 201103L <= YY_CPLUSPLUS
    /// Instantiate a \a T in here from \a t.
    template <typename T, typename... U>
    T&
    emplace (U&&... u)
    {
      return *new (yyas_<T> ()) T (std::forward <U>(u)...);
    }
# else
    /// Instantiate an empty \a T in here.
    template <typename T>
    T&
    emplace ()
    {
      return *new (yyas_<T> ()) T ();
    }

    /// Instantiate a \a T in here from \a t.
    template <typename T>
    T&
    emplace (const T& t)
    {
      return *new (yyas_<T> ()) T (t);
    }
# endif

    /// Instantiate an empty \a T in here.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build ()
    {
      return emplace<T> ();
    }

    /// Instantiate a \a T in here from \a t.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build (const T& t)
    {
      return emplace<T> (t);
    }

    /// Accessor to a built \a T.
    template <typename T>
    T&
    as () YY_NOEXCEPT
    {
      return *yyas_<T> ();
    }

    /// Const accessor to a built \a T (for %printer).
    template <typename T>
    const T&
    as () const YY_NOEXCEPT
    {
      return *yyas_<T> ();
    }

    /// Swap the content with \a that, of same type.
    ///
    /// Both variants must be built beforehand, because swapping the actual
    /// data requires reading it (with as()), and this is not possible on
    /// unconstructed variants: it would require some dynamic testing, which
    /// should not be the variant's responsibility.
    /// Swapping between built and (possibly) non-built is done with
    /// self_type::move ().
    template <typename T>
    void
    swap (self_type& that) YY_NOEXCEPT
    {
      std::swap (as<T> (), that.as<T> ());
    }

    /// Move the content of \a that to this.
    ///
    /// Destroys \a that.
    template <typename T>
    void
    move (self_type& that)
    {
# if 201103L <= YY_CPLUSPLUS
      emplace<T> (std::move (that.as<T> ()));
# else
      emplace<T> ();
      swap<T> (that);
# endif
      that.destroy<T> ();
    }

# if 201103L <= YY_CPLUSPLUS
    /// Move the content of \a that to this.
    template <typename T>
    void
    move (self_type&& that)
    {
      emplace<T> (std::move (that.as<T> ()));
      that.destroy<T> ();
    }
#endif

    /// Copy the content of \a that to this.
    template <typename T>
    void
    copy (const self_type& that)
    {
      emplace<T> (that.as<T> ());
    }

    /// Destroy the stored \a T.
    template <typename T>
    void
    destroy ()
    {
      as<T> ().~T ();
    }

  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    value_type (const self_type&);
    /// Non copyable.
    self_type& operator= (const self_type&);
#endif

    /// Accessor to raw memory as \a T.
    template <typename T>
    T*
    yyas_ () YY_NOEXCEPT
    {
      void *yyp = yyraw_;
      return static_cast<T*> (yyp);
     }

    /// Const accessor to raw memory as \a T.
    template <typename T>
    const T*
    yyas_ () const YY_NOEXCEPT
    {
      const void *yyp = yyraw_;
      return static_cast<const T*> (yyp);
     }

    /// An auxiliary type to compute the largest semantic type.
    union union_type
    {
      // Type
      char dummy1[sizeof (AST_Type)];

      // AddExp
      char dummy2[sizeof (AddExp*)];

      // Block
      char dummy3[sizeof (Block*)];

      // BlockItems
      char dummy4[sizeof (BlockItems*)];

      // CallParams
      char dummy5[sizeof (CallParams*)];

      // CompUnit
      char dummy6[sizeof (CompUnit*)];

      // ConstDecl
      char dummy7[sizeof (ConstDecl*)];

      // ConstDef
      char dummy8[sizeof (ConstDef*)];

      // ConstDefs
      char dummy9[sizeof (ConstDefs*)];

      // EqExp
      char dummy10[sizeof (EqExp*)];

      // ConstExps
      // ArraySubscripts
      char dummy11[sizeof (Exps*)];

      // FuncDef
      char dummy12[sizeof (FuncDef*)];

      // FuncParam
      char dummy13[sizeof (FuncParam*)];

      // FuncParams
      char dummy14[sizeof (FuncParams*)];

      // PrimaryExp
      char dummy15[sizeof (HasOperand*)];

      // ConstInitVal
      // InitVal
      char dummy16[sizeof (InitVal*)];

      // ConstInitVals
      // InitVals
      char dummy17[sizeof (InitVals*)];

      // LAndExp
      char dummy18[sizeof (LAndExp*)];

      // LOrExp
      char dummy19[sizeof (LOrExp*)];

      // LVal
      char dummy20[sizeof (LVal*)];

      // MulExp
      char dummy21[sizeof (MulExp*)];

      // RelExp
      char dummy22[sizeof (RelExp*)];

      // Decl
      // BlockItem
      // Stmt
      char dummy23[sizeof (Stmt*)];

      // UnaryExp
      char dummy24[sizeof (UnaryExp*)];

      // VarDecl
      char dummy25[sizeof (VarDecl*)];

      // VarDef
      char dummy26[sizeof (VarDef*)];

      // VarDefs
      char dummy27[sizeof (VarDefs*)];

      // num_FLOAT
      char dummy28[sizeof (float)];

      // num_INT
      char dummy29[sizeof (int)];

      // Y_ID
      char dummy30[sizeof (std::string)];
    };

    /// The size of the largest semantic type.
    enum { size = sizeof (union_type) };

    /// A buffer to store semantic values.
    union
    {
      /// Strongest alignment constraints.
      long double yyalign_me_;
      /// A buffer large enough to store any of the semantic values.
      char yyraw_[size];
    };
  };

#endif
    /// Backward compatibility (Bison 3.8).
    typedef value_type semantic_type;

    /// Symbol locations.
    typedef LocType location_type;

    /// Syntax errors thrown from user actions.
    struct syntax_error : std::runtime_error
    {
      syntax_error (const location_type& l, const std::string& m)
        : std::runtime_error (m)
        , location (l)
      {}

      syntax_error (const syntax_error& s)
        : std::runtime_error (s.what ())
        , location (s.location)
      {}

      ~syntax_error () YY_NOEXCEPT YY_NOTHROW;

      location_type location;
    };

    /// Token kinds.
    struct token
    {
      enum token_kind_type
      {
        YYEMPTY = -2,
    YYEOF = 0,                     // "end of file"
    YYerror = 256,                 // error
    YYUNDEF = 257,                 // "invalid token"
    Y_INT = 258,                   // Y_INT
    Y_FLOAT = 259,                 // Y_FLOAT
    Y_VOID = 260,                  // Y_VOID
    Y_CONST = 261,                 // Y_CONST
    Y_BREAK = 262,                 // Y_BREAK
    Y_WHILE = 263,                 // Y_WHILE
    Y_IF = 264,                    // Y_IF
    Y_ELSE = 265,                  // Y_ELSE
    Y_RETURN = 266,                // Y_RETURN
    Y_CONTINUE = 267,              // Y_CONTINUE
    Y_ID = 268,                    // Y_ID
    num_FLOAT = 269,               // num_FLOAT
    num_INT = 270,                 // num_INT
    Y_ADD = 271,                   // Y_ADD
    Y_SUB = 272,                   // Y_SUB
    Y_MUL = 273,                   // Y_MUL
    Y_MODULO = 274,                // Y_MODULO
    Y_DIV = 275,                   // Y_DIV
    Y_GREAT = 276,                 // Y_GREAT
    Y_GREATEQ = 277,               // Y_GREATEQ
    Y_LESS = 278,                  // Y_LESS
    Y_LESSEQ = 279,                // Y_LESSEQ
    Y_EQ = 280,                    // Y_EQ
    Y_ASSIGN = 281,                // Y_ASSIGN
    Y_NOTEQ = 282,                 // Y_NOTEQ
    Y_NOT = 283,                   // Y_NOT
    Y_AND = 284,                   // Y_AND
    Y_OR = 285,                    // Y_OR
    Y_LPAR = 286,                  // Y_LPAR
    Y_RPAR = 287,                  // Y_RPAR
    Y_LSQUARE = 288,               // Y_LSQUARE
    Y_RSQUARE = 289,               // Y_RSQUARE
    Y_LBRACKET = 290,              // Y_LBRACKET
    Y_RBRACKET = 291,              // Y_RBRACKET
    Y_SEMICOLON = 292,             // Y_SEMICOLON
    Y_COMMA = 293                  // Y_COMMA
      };
      /// Backward compatibility alias (Bison 3.6).
      typedef token_kind_type yytokentype;
    };

    /// Token kind, as returned by yylex.
    typedef token::token_kind_type token_kind_type;

    /// Backward compatibility alias (Bison 3.6).
    typedef token_kind_type token_type;

    /// Symbol kinds.
    struct symbol_kind
    {
      enum symbol_kind_type
      {
        YYNTOKENS = 39, ///< Number of tokens.
        S_YYEMPTY = -2,
        S_YYEOF = 0,                             // "end of file"
        S_YYerror = 1,                           // error
        S_YYUNDEF = 2,                           // "invalid token"
        S_Y_INT = 3,                             // Y_INT
        S_Y_FLOAT = 4,                           // Y_FLOAT
        S_Y_VOID = 5,                            // Y_VOID
        S_Y_CONST = 6,                           // Y_CONST
        S_Y_BREAK = 7,                           // Y_BREAK
        S_Y_WHILE = 8,                           // Y_WHILE
        S_Y_IF = 9,                              // Y_IF
        S_Y_ELSE = 10,                           // Y_ELSE
        S_Y_RETURN = 11,                         // Y_RETURN
        S_Y_CONTINUE = 12,                       // Y_CONTINUE
        S_Y_ID = 13,                             // Y_ID
        S_num_FLOAT = 14,                        // num_FLOAT
        S_num_INT = 15,                          // num_INT
        S_Y_ADD = 16,                            // Y_ADD
        S_Y_SUB = 17,                            // Y_SUB
        S_Y_MUL = 18,                            // Y_MUL
        S_Y_MODULO = 19,                         // Y_MODULO
        S_Y_DIV = 20,                            // Y_DIV
        S_Y_GREAT = 21,                          // Y_GREAT
        S_Y_GREATEQ = 22,                        // Y_GREATEQ
        S_Y_LESS = 23,                           // Y_LESS
        S_Y_LESSEQ = 24,                         // Y_LESSEQ
        S_Y_EQ = 25,                             // Y_EQ
        S_Y_ASSIGN = 26,                         // Y_ASSIGN
        S_Y_NOTEQ = 27,                          // Y_NOTEQ
        S_Y_NOT = 28,                            // Y_NOT
        S_Y_AND = 29,                            // Y_AND
        S_Y_OR = 30,                             // Y_OR
        S_Y_LPAR = 31,                           // Y_LPAR
        S_Y_RPAR = 32,                           // Y_RPAR
        S_Y_LSQUARE = 33,                        // Y_LSQUARE
        S_Y_RSQUARE = 34,                        // Y_RSQUARE
        S_Y_LBRACKET = 35,                       // Y_LBRACKET
        S_Y_RBRACKET = 36,                       // Y_RBRACKET
        S_Y_SEMICOLON = 37,                      // Y_SEMICOLON
        S_Y_COMMA = 38,                          // Y_COMMA
        S_YYACCEPT = 39,                         // $accept
        S_GrammarEntrance = 40,                  // GrammarEntrance
        S_CompUnit = 41,                         // CompUnit
        S_Decl = 42,                             // Decl
        S_ConstDecl = 43,                        // ConstDecl
        S_ConstDefs = 44,                        // ConstDefs
        S_ConstDef = 45,                         // ConstDef
        S_ConstExps = 46,                        // ConstExps
        S_ConstInitVal = 47,                     // ConstInitVal
        S_ConstInitVals = 48,                    // ConstInitVals
        S_VarDecl = 49,                          // VarDecl
        S_VarDefs = 50,                          // VarDefs
        S_VarDef = 51,                           // VarDef
        S_InitVal = 52,                          // InitVal
        S_InitVals = 53,                         // InitVals
        S_FuncDef = 54,                          // FuncDef
        S_FuncParams = 55,                       // FuncParams
        S_FuncParam = 56,                        // FuncParam
        S_Block = 57,                            // Block
        S_BlockItems = 58,                       // BlockItems
        S_BlockItem = 59,                        // BlockItem
        S_Stmt = 60,                             // Stmt
        S_LVal = 61,                             // LVal
        S_ArraySubscripts = 62,                  // ArraySubscripts
        S_PrimaryExp = 63,                       // PrimaryExp
        S_UnaryExp = 64,                         // UnaryExp
        S_CallParams = 65,                       // CallParams
        S_MulExp = 66,                           // MulExp
        S_AddExp = 67,                           // AddExp
        S_RelExp = 68,                           // RelExp
        S_EqExp = 69,                            // EqExp
        S_LAndExp = 70,                          // LAndExp
        S_LOrExp = 71,                           // LOrExp
        S_Type = 72                              // Type
      };
    };

    /// (Internal) symbol kind.
    typedef symbol_kind::symbol_kind_type symbol_kind_type;

    /// The number of tokens.
    static const symbol_kind_type YYNTOKENS = symbol_kind::YYNTOKENS;

    /// A complete symbol.
    ///
    /// Expects its Base type to provide access to the symbol kind
    /// via kind ().
    ///
    /// Provide access to semantic value and location.
    template <typename Base>
    struct basic_symbol : Base
    {
      /// Alias to Base.
      typedef Base super_type;

      /// Default constructor.
      basic_symbol () YY_NOEXCEPT
        : value ()
        , location ()
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      basic_symbol (basic_symbol&& that)
        : Base (std::move (that))
        , value ()
        , location (std::move (that.location))
      {
        switch (this->kind ())
    {
      case symbol_kind::S_Type: // Type
        value.move< AST_Type > (std::move (that.value));
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.move< AddExp* > (std::move (that.value));
        break;

      case symbol_kind::S_Block: // Block
        value.move< Block* > (std::move (that.value));
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.move< BlockItems* > (std::move (that.value));
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.move< CallParams* > (std::move (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< CompUnit* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.move< ConstDecl* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.move< ConstDef* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.move< ConstDefs* > (std::move (that.value));
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.move< EqExp* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< Exps* > (std::move (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< FuncDef* > (std::move (that.value));
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.move< FuncParam* > (std::move (that.value));
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.move< FuncParams* > (std::move (that.value));
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.move< HasOperand* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.move< InitVal* > (std::move (that.value));
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.move< InitVals* > (std::move (that.value));
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.move< LAndExp* > (std::move (that.value));
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.move< LOrExp* > (std::move (that.value));
        break;

      case symbol_kind::S_LVal: // LVal
        value.move< LVal* > (std::move (that.value));
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.move< MulExp* > (std::move (that.value));
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.move< RelExp* > (std::move (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.move< Stmt* > (std::move (that.value));
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.move< UnaryExp* > (std::move (that.value));
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.move< VarDecl* > (std::move (that.value));
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.move< VarDef* > (std::move (that.value));
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.move< VarDefs* > (std::move (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< float > (std::move (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< int > (std::move (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< std::string > (std::move (that.value));
        break;

      default:
        break;
    }

      }
#endif

      /// Copy constructor.
      basic_symbol (const basic_symbol& that);

      /// Constructors for typed symbols.
#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, location_type&& l)
        : Base (t)
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const location_type& l)
        : Base (t)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, AST_Type&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const AST_Type& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, AddExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const AddExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, Block*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const Block*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, BlockItems*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const BlockItems*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, CallParams*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const CallParams*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, CompUnit*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const CompUnit*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, ConstDecl*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const ConstDecl*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, ConstDef*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const ConstDef*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, ConstDefs*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const ConstDefs*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, EqExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const EqExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, Exps*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const Exps*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, FuncDef*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const FuncDef*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, FuncParam*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const FuncParam*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, FuncParams*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const FuncParams*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, HasOperand*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const HasOperand*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, InitVal*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const InitVal*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, InitVals*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const InitVals*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, LAndExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const LAndExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, LOrExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const LOrExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, LVal*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const LVal*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, MulExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const MulExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, RelExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const RelExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, Stmt*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const Stmt*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, UnaryExp*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const UnaryExp*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, VarDecl*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const VarDecl*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, VarDef*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const VarDef*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, VarDefs*&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const VarDefs*& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, float&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const float& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, int&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const int& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::string&& v, location_type&& l)
        : Base (t)
        , value (std::move (v))
        , location (std::move (l))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::string& v, const location_type& l)
        : Base (t)
        , value (v)
        , location (l)
      {}
#endif

      /// Destroy the symbol.
      ~basic_symbol ()
      {
        clear ();
      }



      /// Destroy contents, and record that is empty.
      void clear () YY_NOEXCEPT
      {
        // User destructor.
        symbol_kind_type yykind = this->kind ();
        basic_symbol<Base>& yysym = *this;
        (void) yysym;
        switch (yykind)
        {
       default:
          break;
        }

        // Value type destructor.
switch (yykind)
    {
      case symbol_kind::S_Type: // Type
        value.template destroy< AST_Type > ();
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.template destroy< AddExp* > ();
        break;

      case symbol_kind::S_Block: // Block
        value.template destroy< Block* > ();
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.template destroy< BlockItems* > ();
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.template destroy< CallParams* > ();
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.template destroy< CompUnit* > ();
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.template destroy< ConstDecl* > ();
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.template destroy< ConstDef* > ();
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.template destroy< ConstDefs* > ();
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.template destroy< EqExp* > ();
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.template destroy< Exps* > ();
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.template destroy< FuncDef* > ();
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.template destroy< FuncParam* > ();
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.template destroy< FuncParams* > ();
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.template destroy< HasOperand* > ();
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.template destroy< InitVal* > ();
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.template destroy< InitVals* > ();
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.template destroy< LAndExp* > ();
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.template destroy< LOrExp* > ();
        break;

      case symbol_kind::S_LVal: // LVal
        value.template destroy< LVal* > ();
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.template destroy< MulExp* > ();
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.template destroy< RelExp* > ();
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.template destroy< Stmt* > ();
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.template destroy< UnaryExp* > ();
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.template destroy< VarDecl* > ();
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.template destroy< VarDef* > ();
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.template destroy< VarDefs* > ();
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.template destroy< float > ();
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.template destroy< int > ();
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.template destroy< std::string > ();
        break;

      default:
        break;
    }

        Base::clear ();
      }

#if YYDEBUG || 0
      /// The user-facing name of this symbol.
      const char *name () const YY_NOEXCEPT
      {
        return parser::symbol_name (this->kind ());
      }
#endif // #if YYDEBUG || 0


      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// Whether empty.
      bool empty () const YY_NOEXCEPT;

      /// Destructive move, \a s is emptied into this.
      void move (basic_symbol& s);

      /// The semantic value.
      value_type value;

      /// The location.
      location_type location;

    private:
#if YY_CPLUSPLUS < 201103L
      /// Assignment operator.
      basic_symbol& operator= (const basic_symbol& that);
#endif
    };

    /// Type access provider for token (enum) based symbols.
    struct by_kind
    {
      /// The symbol kind as needed by the constructor.
      typedef token_kind_type kind_type;

      /// Default constructor.
      by_kind () YY_NOEXCEPT;

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      by_kind (by_kind&& that) YY_NOEXCEPT;
#endif

      /// Copy constructor.
      by_kind (const by_kind& that) YY_NOEXCEPT;

      /// Constructor from (external) token numbers.
      by_kind (kind_type t) YY_NOEXCEPT;



      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_kind& that);

      /// The (internal) type number (corresponding to \a type).
      /// \a empty when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// The symbol kind.
      /// \a S_YYEMPTY when empty.
      symbol_kind_type kind_;
    };

    /// Backward compatibility for a private implementation detail (Bison 3.6).
    typedef by_kind by_type;

    /// "External" symbols: returned by the scanner.
    struct symbol_type : basic_symbol<by_kind>
    {
      /// Superclass.
      typedef basic_symbol<by_kind> super_type;

      /// Empty symbol.
      symbol_type () YY_NOEXCEPT {}

      /// Constructor for valueless symbols, and symbols from each type.
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, location_type l)
        : super_type (token_kind_type (tok), std::move (l))
#else
      symbol_type (int tok, const location_type& l)
        : super_type (token_kind_type (tok), l)
#endif
      {}
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, float v, location_type l)
        : super_type (token_kind_type (tok), std::move (v), std::move (l))
#else
      symbol_type (int tok, const float& v, const location_type& l)
        : super_type (token_kind_type (tok), v, l)
#endif
      {}
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, int v, location_type l)
        : super_type (token_kind_type (tok), std::move (v), std::move (l))
#else
      symbol_type (int tok, const int& v, const location_type& l)
        : super_type (token_kind_type (tok), v, l)
#endif
      {}
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, std::string v, location_type l)
        : super_type (token_kind_type (tok), std::move (v), std::move (l))
#else
      symbol_type (int tok, const std::string& v, const location_type& l)
        : super_type (token_kind_type (tok), v, l)
#endif
      {}
    };

    /// Build a parser object.
    parser ();
    virtual ~parser ();

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    parser (const parser&) = delete;
    /// Non copyable.
    parser& operator= (const parser&) = delete;
#endif

    /// Parse.  An alias for parse ().
    /// \returns  0 iff parsing succeeded.
    int operator() ();

    /// Parse.
    /// \returns  0 iff parsing succeeded.
    virtual int parse ();

#if YYDEBUG
    /// The current debugging stream.
    std::ostream& debug_stream () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging stream.
    void set_debug_stream (std::ostream &);

    /// Type for debugging levels.
    typedef int debug_level_type;
    /// The current debugging level.
    debug_level_type debug_level () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging level.
    void set_debug_level (debug_level_type l);
#endif

    /// Report a syntax error.
    /// \param loc    where the syntax error is found.
    /// \param msg    a description of the syntax error.
    virtual void error (const location_type& loc, const std::string& msg);

    /// Report a syntax error.
    void error (const syntax_error& err);

#if YYDEBUG || 0
    /// The user-facing name of the symbol whose (internal) number is
    /// YYSYMBOL.  No bounds checking.
    static const char *symbol_name (symbol_kind_type yysymbol);
#endif // #if YYDEBUG || 0


    // Implementation of make_symbol for each token kind.
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYEOF (location_type l)
      {
        return symbol_type (token::YYEOF, std::move (l));
      }
#else
      static
      symbol_type
      make_YYEOF (const location_type& l)
      {
        return symbol_type (token::YYEOF, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYerror (location_type l)
      {
        return symbol_type (token::YYerror, std::move (l));
      }
#else
      static
      symbol_type
      make_YYerror (const location_type& l)
      {
        return symbol_type (token::YYerror, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYUNDEF (location_type l)
      {
        return symbol_type (token::YYUNDEF, std::move (l));
      }
#else
      static
      symbol_type
      make_YYUNDEF (const location_type& l)
      {
        return symbol_type (token::YYUNDEF, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_INT (location_type l)
      {
        return symbol_type (token::Y_INT, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_INT (const location_type& l)
      {
        return symbol_type (token::Y_INT, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_FLOAT (location_type l)
      {
        return symbol_type (token::Y_FLOAT, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_FLOAT (const location_type& l)
      {
        return symbol_type (token::Y_FLOAT, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_VOID (location_type l)
      {
        return symbol_type (token::Y_VOID, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_VOID (const location_type& l)
      {
        return symbol_type (token::Y_VOID, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_CONST (location_type l)
      {
        return symbol_type (token::Y_CONST, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_CONST (const location_type& l)
      {
        return symbol_type (token::Y_CONST, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_BREAK (location_type l)
      {
        return symbol_type (token::Y_BREAK, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_BREAK (const location_type& l)
      {
        return symbol_type (token::Y_BREAK, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_WHILE (location_type l)
      {
        return symbol_type (token::Y_WHILE, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_WHILE (const location_type& l)
      {
        return symbol_type (token::Y_WHILE, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_IF (location_type l)
      {
        return symbol_type (token::Y_IF, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_IF (const location_type& l)
      {
        return symbol_type (token::Y_IF, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_ELSE (location_type l)
      {
        return symbol_type (token::Y_ELSE, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_ELSE (const location_type& l)
      {
        return symbol_type (token::Y_ELSE, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_RETURN (location_type l)
      {
        return symbol_type (token::Y_RETURN, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_RETURN (const location_type& l)
      {
        return symbol_type (token::Y_RETURN, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_CONTINUE (location_type l)
      {
        return symbol_type (token::Y_CONTINUE, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_CONTINUE (const location_type& l)
      {
        return symbol_type (token::Y_CONTINUE, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_ID (std::string v, location_type l)
      {
        return symbol_type (token::Y_ID, std::move (v), std::move (l));
      }
#else
      static
      symbol_type
      make_Y_ID (const std::string& v, const location_type& l)
      {
        return symbol_type (token::Y_ID, v, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_num_FLOAT (float v, location_type l)
      {
        return symbol_type (token::num_FLOAT, std::move (v), std::move (l));
      }
#else
      static
      symbol_type
      make_num_FLOAT (const float& v, const location_type& l)
      {
        return symbol_type (token::num_FLOAT, v, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_num_INT (int v, location_type l)
      {
        return symbol_type (token::num_INT, std::move (v), std::move (l));
      }
#else
      static
      symbol_type
      make_num_INT (const int& v, const location_type& l)
      {
        return symbol_type (token::num_INT, v, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_ADD (location_type l)
      {
        return symbol_type (token::Y_ADD, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_ADD (const location_type& l)
      {
        return symbol_type (token::Y_ADD, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_SUB (location_type l)
      {
        return symbol_type (token::Y_SUB, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_SUB (const location_type& l)
      {
        return symbol_type (token::Y_SUB, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_MUL (location_type l)
      {
        return symbol_type (token::Y_MUL, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_MUL (const location_type& l)
      {
        return symbol_type (token::Y_MUL, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_MODULO (location_type l)
      {
        return symbol_type (token::Y_MODULO, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_MODULO (const location_type& l)
      {
        return symbol_type (token::Y_MODULO, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_DIV (location_type l)
      {
        return symbol_type (token::Y_DIV, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_DIV (const location_type& l)
      {
        return symbol_type (token::Y_DIV, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_GREAT (location_type l)
      {
        return symbol_type (token::Y_GREAT, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_GREAT (const location_type& l)
      {
        return symbol_type (token::Y_GREAT, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_GREATEQ (location_type l)
      {
        return symbol_type (token::Y_GREATEQ, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_GREATEQ (const location_type& l)
      {
        return symbol_type (token::Y_GREATEQ, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_LESS (location_type l)
      {
        return symbol_type (token::Y_LESS, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_LESS (const location_type& l)
      {
        return symbol_type (token::Y_LESS, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_LESSEQ (location_type l)
      {
        return symbol_type (token::Y_LESSEQ, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_LESSEQ (const location_type& l)
      {
        return symbol_type (token::Y_LESSEQ, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_EQ (location_type l)
      {
        return symbol_type (token::Y_EQ, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_EQ (const location_type& l)
      {
        return symbol_type (token::Y_EQ, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_ASSIGN (location_type l)
      {
        return symbol_type (token::Y_ASSIGN, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_ASSIGN (const location_type& l)
      {
        return symbol_type (token::Y_ASSIGN, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_NOTEQ (location_type l)
      {
        return symbol_type (token::Y_NOTEQ, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_NOTEQ (const location_type& l)
      {
        return symbol_type (token::Y_NOTEQ, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_NOT (location_type l)
      {
        return symbol_type (token::Y_NOT, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_NOT (const location_type& l)
      {
        return symbol_type (token::Y_NOT, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_AND (location_type l)
      {
        return symbol_type (token::Y_AND, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_AND (const location_type& l)
      {
        return symbol_type (token::Y_AND, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_OR (location_type l)
      {
        return symbol_type (token::Y_OR, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_OR (const location_type& l)
      {
        return symbol_type (token::Y_OR, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_LPAR (location_type l)
      {
        return symbol_type (token::Y_LPAR, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_LPAR (const location_type& l)
      {
        return symbol_type (token::Y_LPAR, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_RPAR (location_type l)
      {
        return symbol_type (token::Y_RPAR, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_RPAR (const location_type& l)
      {
        return symbol_type (token::Y_RPAR, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_LSQUARE (location_type l)
      {
        return symbol_type (token::Y_LSQUARE, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_LSQUARE (const location_type& l)
      {
        return symbol_type (token::Y_LSQUARE, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_RSQUARE (location_type l)
      {
        return symbol_type (token::Y_RSQUARE, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_RSQUARE (const location_type& l)
      {
        return symbol_type (token::Y_RSQUARE, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_LBRACKET (location_type l)
      {
        return symbol_type (token::Y_LBRACKET, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_LBRACKET (const location_type& l)
      {
        return symbol_type (token::Y_LBRACKET, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_RBRACKET (location_type l)
      {
        return symbol_type (token::Y_RBRACKET, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_RBRACKET (const location_type& l)
      {
        return symbol_type (token::Y_RBRACKET, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_SEMICOLON (location_type l)
      {
        return symbol_type (token::Y_SEMICOLON, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_SEMICOLON (const location_type& l)
      {
        return symbol_type (token::Y_SEMICOLON, l);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_Y_COMMA (location_type l)
      {
        return symbol_type (token::Y_COMMA, std::move (l));
      }
#else
      static
      symbol_type
      make_Y_COMMA (const location_type& l)
      {
        return symbol_type (token::Y_COMMA, l);
      }
#endif


  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    parser (const parser&);
    /// Non copyable.
    parser& operator= (const parser&);
#endif


    /// Stored state numbers (used for stacks).
    typedef unsigned char state_type;

    /// Compute post-reduction state.
    /// \param yystate   the current state
    /// \param yysym     the nonterminal to push on the stack
    static state_type yy_lr_goto_state_ (state_type yystate, int yysym);

    /// Whether the given \c yypact_ value indicates a defaulted state.
    /// \param yyvalue   the value to check
    static bool yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT;

    /// Whether the given \c yytable_ value indicates a syntax error.
    /// \param yyvalue   the value to check
    static bool yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT;

    static const signed char yypact_ninf_;
    static const signed char yytable_ninf_;

    /// Convert a scanner token kind \a t to a symbol kind.
    /// In theory \a t should be a token_kind_type, but character literals
    /// are valid, yet not members of the token_kind_type enum.
    static symbol_kind_type yytranslate_ (int t) YY_NOEXCEPT;

#if YYDEBUG || 0
    /// For a symbol, its name in clear.
    static const char* const yytname_[];
#endif // #if YYDEBUG || 0


    // Tables.
    // YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    // STATE-NUM.
    static const short yypact_[];

    // YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
    // Performed when YYTABLE does not specify something else to do.  Zero
    // means the default is an error.
    static const signed char yydefact_[];

    // YYPGOTO[NTERM-NUM].
    static const short yypgoto_[];

    // YYDEFGOTO[NTERM-NUM].
    static const unsigned char yydefgoto_[];

    // YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
    // positive, shift that token.  If negative, reduce the rule whose
    // number is the opposite.  If YYTABLE_NINF, syntax error.
    static const unsigned char yytable_[];

    static const short yycheck_[];

    // YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
    // state STATE-NUM.
    static const signed char yystos_[];

    // YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.
    static const signed char yyr1_[];

    // YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.
    static const signed char yyr2_[];


#if YYDEBUG
    // YYRLINE[YYN] -- Source line where rule number YYN was defined.
    static const short yyrline_[];
    /// Report on the debug stream that the rule \a r is going to be reduced.
    virtual void yy_reduce_print_ (int r) const;
    /// Print the state stack on the debug stream.
    virtual void yy_stack_print_ () const;

    /// Debugging level.
    int yydebug_;
    /// Debug stream.
    std::ostream* yycdebug_;

    /// \brief Display a symbol kind, value and location.
    /// \param yyo    The output stream.
    /// \param yysym  The symbol.
    template <typename Base>
    void yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const;
#endif

    /// \brief Reclaim the memory associated to a symbol.
    /// \param yymsg     Why this token is reclaimed.
    ///                  If null, print nothing.
    /// \param yysym     The symbol.
    template <typename Base>
    void yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const;

  private:
    /// Type access provider for state based symbols.
    struct by_state
    {
      /// Default constructor.
      by_state () YY_NOEXCEPT;

      /// The symbol kind as needed by the constructor.
      typedef state_type kind_type;

      /// Constructor.
      by_state (kind_type s) YY_NOEXCEPT;

      /// Copy constructor.
      by_state (const by_state& that) YY_NOEXCEPT;

      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_state& that);

      /// The symbol kind (corresponding to \a state).
      /// \a symbol_kind::S_YYEMPTY when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// The state number used to denote an empty symbol.
      /// We use the initial state, as it does not have a value.
      enum { empty_state = 0 };

      /// The state.
      /// \a empty when empty.
      state_type state;
    };

    /// "Internal" symbol: element of the stack.
    struct stack_symbol_type : basic_symbol<by_state>
    {
      /// Superclass.
      typedef basic_symbol<by_state> super_type;
      /// Construct an empty symbol.
      stack_symbol_type ();
      /// Move or copy construction.
      stack_symbol_type (YY_RVREF (stack_symbol_type) that);
      /// Steal the contents from \a sym to build this.
      stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) sym);
#if YY_CPLUSPLUS < 201103L
      /// Assignment, needed by push_back by some old implementations.
      /// Moves the contents of that.
      stack_symbol_type& operator= (stack_symbol_type& that);

      /// Assignment, needed by push_back by other implementations.
      /// Needed by some other old implementations.
      stack_symbol_type& operator= (const stack_symbol_type& that);
#endif
    };

    /// A stack with random access from its top.
    template <typename T, typename S = std::vector<T> >
    class stack
    {
    public:
      // Hide our reversed order.
      typedef typename S::iterator iterator;
      typedef typename S::const_iterator const_iterator;
      typedef typename S::size_type size_type;
      typedef typename std::ptrdiff_t index_type;

      stack (size_type n = 200) YY_NOEXCEPT
        : seq_ (n)
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Non copyable.
      stack (const stack&) = delete;
      /// Non copyable.
      stack& operator= (const stack&) = delete;
#endif

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      const T&
      operator[] (index_type i) const
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      T&
      operator[] (index_type i)
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Steal the contents of \a t.
      ///
      /// Close to move-semantics.
      void
      push (YY_MOVE_REF (T) t)
      {
        seq_.push_back (T ());
        operator[] (0).move (t);
      }

      /// Pop elements from the stack.
      void
      pop (std::ptrdiff_t n = 1) YY_NOEXCEPT
      {
        for (; 0 < n; --n)
          seq_.pop_back ();
      }

      /// Pop all elements from the stack.
      void
      clear () YY_NOEXCEPT
      {
        seq_.clear ();
      }

      /// Number of elements on the stack.
      index_type
      size () const YY_NOEXCEPT
      {
        return index_type (seq_.size ());
      }

      /// Iterator on top of the stack (going downwards).
      const_iterator
      begin () const YY_NOEXCEPT
      {
        return seq_.begin ();
      }

      /// Bottom of the stack.
      const_iterator
      end () const YY_NOEXCEPT
      {
        return seq_.end ();
      }

      /// Present a slice of the top of a stack.
      class slice
      {
      public:
        slice (const stack& stack, index_type range) YY_NOEXCEPT
          : stack_ (stack)
          , range_ (range)
        {}

        const T&
        operator[] (index_type i) const
        {
          return stack_[range_ - i];
        }

      private:
        const stack& stack_;
        index_type range_;
      };

    private:
#if YY_CPLUSPLUS < 201103L
      /// Non copyable.
      stack (const stack&);
      /// Non copyable.
      stack& operator= (const stack&);
#endif
      /// The wrapped container.
      S seq_;
    };


    /// Stack type.
    typedef stack<stack_symbol_type> stack_type;

    /// The stack.
    stack_type yystack_;

    /// Push a new state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param sym  the symbol
    /// \warning the contents of \a s.value is stolen.
    void yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym);

    /// Push a new look ahead token on the state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param s    the state
    /// \param sym  the symbol (for its value and location).
    /// \warning the contents of \a sym.value is stolen.
    void yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym);

    /// Pop \a n symbols from the stack.
    void yypop_ (int n = 1) YY_NOEXCEPT;

    /// Constants.
    enum
    {
      yylast_ = 276,     ///< Last index in yytable_.
      yynnts_ = 34,  ///< Number of nonterminal symbols.
      yyfinal_ = 13 ///< Termination state number.
    };



  };

  inline
  parser::symbol_kind_type
  parser::yytranslate_ (int t) YY_NOEXCEPT
  {
    // YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to
    // TOKEN-NUM as returned by yylex.
    static
    const signed char
    translate_table[] =
    {
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38
    };
    // Last valid token kind.
    const int code_max = 293;

    if (t <= 0)
      return symbol_kind::S_YYEOF;
    else if (t <= code_max)
      return static_cast <symbol_kind_type> (translate_table[t]);
    else
      return symbol_kind::S_YYUNDEF;
  }

  // basic_symbol.
  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (const basic_symbol& that)
    : Base (that)
    , value ()
    , location (that.location)
  {
    switch (this->kind ())
    {
      case symbol_kind::S_Type: // Type
        value.copy< AST_Type > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.copy< AddExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Block: // Block
        value.copy< Block* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.copy< BlockItems* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.copy< CallParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.copy< CompUnit* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.copy< ConstDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.copy< ConstDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.copy< ConstDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.copy< EqExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.copy< Exps* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.copy< FuncDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.copy< FuncParam* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.copy< FuncParams* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.copy< HasOperand* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.copy< InitVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.copy< InitVals* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.copy< LAndExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.copy< LOrExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_LVal: // LVal
        value.copy< LVal* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.copy< MulExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.copy< RelExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.copy< Stmt* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.copy< UnaryExp* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.copy< VarDecl* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.copy< VarDef* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.copy< VarDefs* > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.copy< float > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.copy< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.copy< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

  }




  template <typename Base>
  parser::symbol_kind_type
  parser::basic_symbol<Base>::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


  template <typename Base>
  bool
  parser::basic_symbol<Base>::empty () const YY_NOEXCEPT
  {
    return this->kind () == symbol_kind::S_YYEMPTY;
  }

  template <typename Base>
  void
  parser::basic_symbol<Base>::move (basic_symbol& s)
  {
    super_type::move (s);
    switch (this->kind ())
    {
      case symbol_kind::S_Type: // Type
        value.move< AST_Type > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_AddExp: // AddExp
        value.move< AddExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Block: // Block
        value.move< Block* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_BlockItems: // BlockItems
        value.move< BlockItems* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_CallParams: // CallParams
        value.move< CallParams* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_CompUnit: // CompUnit
        value.move< CompUnit* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstDecl: // ConstDecl
        value.move< ConstDecl* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstDef: // ConstDef
        value.move< ConstDef* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstDefs: // ConstDefs
        value.move< ConstDefs* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_EqExp: // EqExp
        value.move< EqExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstExps: // ConstExps
      case symbol_kind::S_ArraySubscripts: // ArraySubscripts
        value.move< Exps* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_FuncDef: // FuncDef
        value.move< FuncDef* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_FuncParam: // FuncParam
        value.move< FuncParam* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_FuncParams: // FuncParams
        value.move< FuncParams* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_PrimaryExp: // PrimaryExp
        value.move< HasOperand* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstInitVal: // ConstInitVal
      case symbol_kind::S_InitVal: // InitVal
        value.move< InitVal* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_ConstInitVals: // ConstInitVals
      case symbol_kind::S_InitVals: // InitVals
        value.move< InitVals* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_LAndExp: // LAndExp
        value.move< LAndExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_LOrExp: // LOrExp
        value.move< LOrExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_LVal: // LVal
        value.move< LVal* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_MulExp: // MulExp
        value.move< MulExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_RelExp: // RelExp
        value.move< RelExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Decl: // Decl
      case symbol_kind::S_BlockItem: // BlockItem
      case symbol_kind::S_Stmt: // Stmt
        value.move< Stmt* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_UnaryExp: // UnaryExp
        value.move< UnaryExp* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_VarDecl: // VarDecl
        value.move< VarDecl* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_VarDef: // VarDef
        value.move< VarDef* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_VarDefs: // VarDefs
        value.move< VarDefs* > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_num_FLOAT: // num_FLOAT
        value.move< float > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_num_INT: // num_INT
        value.move< int > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_Y_ID: // Y_ID
        value.move< std::string > (YY_MOVE (s.value));
        break;

      default:
        break;
    }

    location = YY_MOVE (s.location);
  }

  // by_kind.
  inline
  parser::by_kind::by_kind () YY_NOEXCEPT
    : kind_ (symbol_kind::S_YYEMPTY)
  {}

#if 201103L <= YY_CPLUSPLUS
  inline
  parser::by_kind::by_kind (by_kind&& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {
    that.clear ();
  }
#endif

  inline
  parser::by_kind::by_kind (const by_kind& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {}

  inline
  parser::by_kind::by_kind (token_kind_type t) YY_NOEXCEPT
    : kind_ (yytranslate_ (t))
  {}



  inline
  void
  parser::by_kind::clear () YY_NOEXCEPT
  {
    kind_ = symbol_kind::S_YYEMPTY;
  }

  inline
  void
  parser::by_kind::move (by_kind& that)
  {
    kind_ = that.kind_;
    that.clear ();
  }

  inline
  parser::symbol_kind_type
  parser::by_kind::kind () const YY_NOEXCEPT
  {
    return kind_;
  }


  inline
  parser::symbol_kind_type
  parser::by_kind::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


} // yy
#line 2888 "parser.hpp"




#endif // !YY_YY_PARSER_HPP_INCLUDED
