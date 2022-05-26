package com.agileway;

public class Resource {
    protected String title;

    public Resource(String aTitle) {
        title = aTitle;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
