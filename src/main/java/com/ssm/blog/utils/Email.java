package com.ssm.blog.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.security.Security;
import java.util.Properties;

public class Email {
    public static void sendSimpleEmail (String emailContent,String emailAddress) throws Exception {
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        Properties prop = new Properties();
        prop.setProperty("mail.host", "smtp.qq.com");
        prop.setProperty("mail.transport.protocol", "smtp");
        prop.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
        prop.setProperty("mail.smtp.socketFactory.fallback", "false");
        prop.setProperty("mail.smtp.port", "465");
        prop.setProperty("mail.smtp.socketFactory.port", "465");
        prop.setProperty("mail.smtp.auth", "true");
        //使用JavaMail发送邮件的5个步骤
        //1、创建session
        Session session = Session.getInstance(prop);
        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
        //session.setDebug(true);
        //2、通过session得到transport对象
        Transport ts = session.getTransport();
        //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要
        // 3.1开通POP3/SMTP/IMAP服务获取到授权码
        // 3.2 提交邮箱的用户名和授权码给smtp服务器，用户名和授权码都通过验证之后才能够正常发送邮件给收件人。
        ts.connect("smtp.qq.com","2415156870@qq.com", "gglmjjvrwhdrdiaa");
        //4、创建邮件
        Message message = createSimpleMail(session,emailContent,emailAddress);
        //5、发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
    }

    public static MimeMessage createSimpleMail(Session session,String emailContent,String emailAddress)
            throws Exception {
        //创建邮件对象
        MimeMessage message = new MimeMessage(session);
        //指明邮件的发件人
        message.setFrom(new InternetAddress("2415156870@qq.com"));
        //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(emailAddress));
        //邮件的标题
        message.setSubject("来自早起不吃虫的留言回复");
        //邮件的文本内容
        message.setContent(emailContent, "text/html;charset=UTF-8");
        //返回创建好的邮件对象
        return message;
    }
}
