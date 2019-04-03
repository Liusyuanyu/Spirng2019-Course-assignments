import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;

public class ClientClass {

    private DatagramSocket socket;
    private InetAddress address;
    private byte[] buf;

    public void ClientStart() throws Exception {
        socket = new DatagramSocket(5433);
        address = InetAddress.getByName("localhost");

        String msgsent="";
        String received ="";
        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
        DatagramPacket packet;
        DatagramPacket packet_rec;
        String fillstr;
        char[] values;

        while(true){
            System.out.print("Enter a sentence: ");
            msgsent = inFromUser.readLine();
            values=new char[256 - msgsent.length()];
            fillstr = new String(values);
            msgsent += fillstr;
            buf = msgsent.getBytes();
            packet = new DatagramPacket(buf, buf.length, address, 5432);
            socket.send(packet);
            if (msgsent.contains("end")) {
                break;
            }
            buf = new byte[256];
            packet_rec = new DatagramPacket(buf, buf.length, address, 5432);
            socket.receive(packet_rec);
            received = new String( packet_rec.getData(), packet_rec.getOffset(), packet_rec.getLength());

            System.out.println("Received: " + received);
        }
        inFromUser.close();
        socket.close();
    }
}
