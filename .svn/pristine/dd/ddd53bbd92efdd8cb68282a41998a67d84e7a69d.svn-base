package com.fh.shop.po;

public class Book {

    private String bookName;

    private Float price;

    private Book() {


    }

    private Book(Book origin) {
        this.bookName = origin.bookName;
        this.price = origin.price;
    }

    public String getBookName() {
        return bookName;
    }

    public Float getPrice() {
        return price;
    }

    public static class Builder {

        private Book target;

        public Builder() {
            target = new Book();
        }

        public Builder bookName(String bookName) {
            target.bookName = bookName;
            return this;
        }

        public Builder price(Float price) {
            target.price = price;
            return this;
        }

        public Book build() {
            return new Book(target);
        }
    }
}
