public class Main {

    public static void main(String[] args) {
        ServerClass Server = new ServerClass();
        try {
            Server.ServerStart();
        } catch (Exception e) {
            e.printStackTrace();
        }
//        System.out.println("Hello World!");
    }
}
