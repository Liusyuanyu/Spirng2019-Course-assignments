public class Main {

    public static void main(String[] args) {
//        System.out.println("Hello World");

        ServerClass Server = new ServerClass();
        try {
            Server.ServerStart();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // write your code here
    }
}
