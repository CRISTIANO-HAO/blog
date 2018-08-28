package com.ssm.blog.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {

    /*
    * HTML转换为纯文本
    *
    * */
    public static String HtmlToString (String html){
        //匹配的正则，把HTML标签替换为空字符
        String REGEX = "<\\/?\\s*\\w+\\s*>";
        String OUTPUT = null;
        String REPLACE = "";

        Pattern p = Pattern.compile(REGEX);
        // get a matcher object
        Matcher m = p.matcher(html);
        OUTPUT = m.replaceAll(REPLACE);
        return OUTPUT;
    }
}
