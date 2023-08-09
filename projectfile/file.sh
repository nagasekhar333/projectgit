import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

class Book {
    private String title;
    private boolean available;

    public Book(String title) {
        this.title = title;
        this.available = true;
    }

    public String getTitle() {
        return title;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}

class User {
    private String username;
    private List<Book> borrowedBooks;

    public User(String username) {
        this.username = username;
        this.borrowedBooks = new ArrayList<>();
    }

    public String getUsername() {
        return username;
    }

    public List<Book> getBorrowedBooks() {
        return borrowedBooks;
    }

    public void borrowBook(Book book) {
        borrowedBooks.add(book);
        book.setAvailable(false);
    }

    public void returnBook(Book book) {
        borrowedBooks.remove(book);
        book.setAvailable(true);
    }
}

public class LibrarySystem {
    private Map<String, Book> books;
    private Map<String, User> users;

    public LibrarySystem() {
        books = new HashMap<>();
        users = new HashMap<>();
    }

    public void addBook(String title) {
        books.put(title, new Book(title));
    }

    public void addUser(String username) {
        users.put(username, new User(username));
    }

    public void borrowBook(String username, String bookTitle) {
        User user = users.get(username);
        Book book = books.get(bookTitle);

        if (user != null && book != null && book.isAvailable()) {
            user.borrowBook(book);
            System.out.println("Book borrowed successfully.");
        } else {
            System.out.println("Book not available for borrowing.");
        }
    }

    public void returnBook(String username, String bookTitle) {
        User user = users.get(username);
        Book book = books.get(bookTitle);

        if (user != null && book != null && !book.isAvailable()) {
            user.returnBook(book);
            System.out.println("Book returned successfully.");
        } else {
            System.out.println("Book cannot be returned.");
        }
    }

    public static void main(String[] args) {
        LibrarySystem library = new LibrarySystem();
        library.addBook("Java Programming");
        library.addBook("Introduction to Algorithms");
        library.addUser("Alice");
        library.addUser("Bob");

        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("1. Borrow Book");
            System.out.println("2. Return Book");
            System.out.println("3. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();  // Consume newline

            switch (choice) {
                case 1:
                    System.out.print("Enter your username: ");
                    String username = scanner.nextLine();
                    System.out.print("Enter book title to borrow: ");
                    String borrowTitle = scanner.nextLine();
                    library.borrowBook(username, borrowTitle);
                    break;
                case 2:
                    System.out.print("Enter your username: ");
                    String returnUsername = scanner.nextLine();
                    System.out.print("Enter book title to return: ");
                    String returnTitle = scanner.nextLine();
                    library.returnBook(returnUsername, returnTitle);
                    break;
                case 3:
                    System.out.println("Exiting the library system.");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice. Please enter a valid option.");
            }
        }
    }
}

