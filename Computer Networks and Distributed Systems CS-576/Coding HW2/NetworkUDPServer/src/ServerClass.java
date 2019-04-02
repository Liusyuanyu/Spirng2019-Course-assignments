import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class ServerClass {
    private DatagramSocket socket;
//    private boolean running;
    private byte[] buf = new byte[256];

    void ServerStart() throws Exception{
        socket = new DatagramSocket(5432);
        DatagramPacket packet ;
        int port = 0;

        while (true) {

            packet = new DatagramPacket(buf, buf.length);
            socket.receive(packet);

            InetAddress address = packet.getAddress();
            port = packet.getPort();
            packet = new DatagramPacket(buf, buf.length, address, port);

            String received = new String(packet.getData(), packet.getOffset(), packet.getLength());
            if (received.equals("end")) {
                break;
            }

            System.out.println("Received: " + received);

            String returnMsg = received + " - Don’t eat yellow snow";
            returnMsg = returnMsg.replaceAll("\0", "");

            buf = new byte[256];
            buf = returnMsg.getBytes();
            packet = new DatagramPacket(buf, buf.length, address, 5433);
            socket.send(packet);
        }

        socket.close();
    }


}
