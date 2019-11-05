package util;

import javax.mail.Authenticator;

import javax.mail.PasswordAuthentication;



public class Email extends Authenticator {

    @Override

    protected PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication("wh4873@naver.com","gu020307");

    }


}

