/*
 * This file is part of duit.
 * 
 * duit is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 * 
 * duit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with duit; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/**
 * grabs the text of an html doc
 */

module utils.HtmlStrip;

//debug=amper;
//debug=file;

public class HtmlStrip
{
	
	private import std.file;
	private import std.stdio;

	public bit convertComment = true;
	public bit markHR = true;
	public bit removeEmptyLines = true;
	public bit removeExtraSpaces = true;
	
	public this()
	{
		
	}
	
	char[] strip(char[] htmlText)
	{
		int markupCount = 0;
		char[] stripped;
		char pc = ' ';
		char[] mark;
		bit inAmper = false;
		char[] amper;
		
		foreach ( char c ; htmlText )
		{
			switch ( c )
			{
				case '<':
					++markupCount;
					mark.length = 0;
					break;
					
				case '>': 
					--markupCount;
					if ( markHR && (mark == "hr" || mark == "HR") )
					{
						stripped ~= "\n<hr>\n";
					}
					break;
					
				case '&':
					inAmper = true;
					amper = "&";
					break;
					
				default:
					if ( inAmper )
					{
						if ( c==';' )
						{
							debug(amper) writefln("amper = ",amper);
							switch ( amper )
							{
								case "&lt"	: c = '<'; break;
								case "&gt"	: c = '>'; break;
								case "&nbsp": c = ' '; break;
								default: c = '\0'; break;
							}
							inAmper = false;
							amper.length = 0;
						}
						else
						{
							amper ~= c;
							c = '\0';
						}
					}
					if ( c == '\0'  )
					{
						// ignore it
					}
					else if ( markupCount <= 0 )
					{
						if ( convertComment && pc == '/' && c == '*' )
						{
							stripped ~= '+';
						}
						if ( convertComment && pc == '*' && c == '/' )
						{
							stripped[stripped.length-1] = '+';
							stripped ~= c;
						}
						else if ( removeEmptyLines 
									&& stripped.length > 2
									&& c == '\n' 
									&& stripped[stripped.length-1] == '\n'
									&& stripped[stripped.length-2] == '\n'
									)
						{
							// ignore this EOL
						}
						else if ( removeEmptyLines 
									&& stripped.length > 2
									&& c == 0x0A 
									&& stripped[stripped.length-1] == 0x0A
									&& stripped[stripped.length-2] == 0x0A
									)
						{
							// ignore this EOL
						}
						else if ( removeExtraSpaces && c == ' ' && pc == ' ' )
						{
							// skip this space
						}
						else
						{
							stripped ~= c;
						}
					}
					else
					{
						mark ~= c;
					}
					break;
			}
			pc = c;
		}
		
		
		return stripped;
	}
	
	char[] stripFile(char[] filename)
	{
		debug(file)writefln("HtmlStrip.stripFile filename = %s", filename);
		char[] text = cast(char[])std.file.read(filename);
		
		//writefln("Original html:\n%s", text);
		
		return strip(text);
	}
	
}

version (standAlone)
{
	
	private import std.stdio;

	int main()
	{

		HtmlStrip strip = new HtmlStrip();
		char[] stripped = strip.stripFile("/home/data/down/GTK/API/glib/glib-The-Main-Event-Loop.html");
	
		writefln("Stripped html:\n%s", stripped);
	
		return 0;
	}
	
}