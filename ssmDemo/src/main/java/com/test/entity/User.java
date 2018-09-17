package com.test.entity;

public class User {
    private Integer uId;

    private String uName;

    private String uGander;

    private String uEmail;

    private Integer dId;
    private Dept dept;

    public User(Integer uId, String uName, String uGander, String uEmail, Integer dId) {
        this.uId = uId;
        this.uName = uName;
        this.uGander = uGander;
        this.uEmail = uEmail;
        this.dId = dId;
    }

    public User() {
    }

    @Override
    public String toString() {
        return "User{" +
                "uId=" + uId +
                ", uName='" + uName + '\'' +
                ", uGander='" + uGander + '\'' +
                ", uEmail='" + uEmail + '\'' +
                ", dId=" + dId +
                '}';
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName == null ? null : uName.trim();
    }

    public String getuGander() {
        return uGander;
    }

    public void setuGander(String uGander) {
        this.uGander = uGander == null ? null : uGander.trim();
    }

    public String getuEmail() {
        return uEmail;
    }

    public void setuEmail(String uEmail) {
        this.uEmail = uEmail == null ? null : uEmail.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}