package shared.utils;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

class MacroFunctions
{
	public static macro function nameOf(e:Expr):Expr
	{
		Context.typeExpr(e);
		return switch (e.expr)
		{
			case EConst(CIdent(s)):
				macro $v{s};
			default:
				Context.error("nameOf requires an indentifier as argument", Context.currentPos());
		}
	}
}
