import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.Socket;

public class Main {

    public static void main(String[] args) {
        ClientClass client = new ClientClass();
        try {
            client.ClientStart();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
