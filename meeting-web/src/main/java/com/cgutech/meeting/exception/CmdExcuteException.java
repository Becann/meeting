package com.cgutech.meeting.exception;

/**
 * 执行命令行异常
 * @author devis on 9/2/2016.
 */
public class CmdExcuteException extends Exception{
    public CmdExcuteException(String message) {
        super(message);
    }

    public CmdExcuteException(String message, Throwable e) {
        super(message, e);
    }
}
