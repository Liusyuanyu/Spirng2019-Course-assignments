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

        while(true){

            System.out.print("Enter a sentence: ");
            msgsent = inFromUser.readLine();
            buf = msgsent.getBytes();
            packet = new DatagramPacket(buf, buf.length, address, 5432);
            socket.send(packet);

            if (msgsent.equals("end")) {
                break;
            }

            buf = new byte[256];
            packet = new DatagramPacket(buf, buf.length, address, 5432);
            socket.receive(packet);
            received = new String( packet.getData(), packet.getOffset(), packet.getLength());

            System.out.println("Received: " + received);

        }
        inFromUser.close();
        socket.close();

//        String sentence;
//        String ReceivedSentence;
//
//
//        Socket clientSocket = null;
//        try {
//            clientSocket = new Socket("localhost", 9576);
//        } catch (ConnectException e) {
//            System.out.println("Fail to connect to the server.");
//            return;
//        }
//
//        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
//        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
//        BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
//
//        System.out.println("Setting:");
//        System.out.println(EncodeMessage+"   : Change the server function which encodes message and return.(Default)");
//        System.out.println(DecodeMessage+"   : Change the server function which decodes message and return.");
//        System.out.println(ShutdownMessage+" : Shutdown the server.");
////        System.out.print("Encode Enter a sentence(less than 256 characters): ");
//        while(true){
//            System.out.print("Enter a sentence(less than 256 characters): ");
//            sentence = inFromUser.readLine();
//
//            if (sentence.length()> 256){
//                System.out.println("The sentence is longer than 256. Slice the sentence.");
//                continue;
//            }
//            if ((SentenceParser(sentence) ==1))
//                break;
//            outToServer.writeBytes(sentence + '\n');
//            ReceivedSentence = inFromServer.readLine();
//            System.out.println("From Server: " + ReceivedSentence);
//        }
//
//        outToServer.writeBytes(ShutdownMessage + '\n');
//        inFromUser.close();
//        inFromServer.close();
//        outToServer.close();
//        clientSocket.close();

    }


}
