/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.profile;

/**
 *
 * @author LENOVO
 */
public class TestProfileBean {
    public static void main(String[] args) {
        ProfileBean p = new ProfileBean();
        p.setName("Ali Ahmad");
        p.setStudentID("2025100178");
        System.out.println("Name: " + p.getName());
        System.out.println("Student ID: " + p.getStudentID());
    }
}

