public class Main {

    public static void main(String[] args) {

//        System.out.println("Hello World!");

        ClientClass client = new ClientClass();
        try {
            client.ClientStart();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
