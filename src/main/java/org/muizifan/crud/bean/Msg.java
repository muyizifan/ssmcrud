package org.muizifan.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类
 * @author tao
 */
public class Msg {
    //状态码 eg.100-成功，200-失败
    private int code;
    //提示信息
    private String msg;

    //用户返回给浏览器的数据
    private Map<String,Object> extend=new HashMap<String,Object>();

    public  static Msg success(){
        Msg resulet=new Msg();
        resulet.setCode(100);
        resulet.setMsg("处理成功！");
        return resulet;
    }
    public  static Msg fail(){
        Msg resulet=new Msg();
        resulet.setCode(200);
        resulet.setMsg("处理失败！");
        return resulet;
    }
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}

