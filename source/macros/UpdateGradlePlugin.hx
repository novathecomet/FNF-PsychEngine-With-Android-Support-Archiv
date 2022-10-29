#if macro
package macros;

import haxe.macro.Compiler;
import haxe.macro.Expr;
using StringTools;
import sys.io.File;
import sys.FileSystem;

class UpdateGradlePlugin {
    public static macro function run(version:String):Expr.ExprOf<String> {
        #if !display
        var folder = '${Compiler.getOutput()}/../bin/';
        var normalFile:String = '';
        if (FileSystem.exists(folder + 'build.gradle')) {
            normalFile = File.getContent(folder + 'build.gradle');
            FileSystem.deleteFile(folder + 'build.gradle');
            var resFile:String = normalFile.replace("::ANDROID_GRADLE_PLUGIN::", version);
            File.saveContent(folder + 'build.gradle', resFile);
            return macro $v{File.getContent(folder + 'build.gradle')};
        }
        return macro $v{"failed"};
        #else
        return macro $v{""};
        #end
    }
}
#end
