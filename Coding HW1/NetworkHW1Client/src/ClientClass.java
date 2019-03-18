import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.Socket;

public class ClientClass {

    //region Indication
    String EncodeMessage = "--Encode";
    String DecodeMessage = "--Decode";
    String ShutdownMessage = "--Shutdown";
    //endregion

    public void ClientStart() throws Exception {
        String sentence;
        String ReceivedSentence;


        Socket clientSocket = null;
        try {
            clientSocket = new Socket("localhost", 9576);
        } catch (ConnectException e) {
            System.out.println("Fail to connect to the server.");
            return;
        }

        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
        BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

        System.out.println("Setting:");
        System.out.println(EncodeMessage+"   : Change the server function which encodes message and return.(Default)");
        System.out.println(DecodeMessage+"   : Change the server function which decodes message and return.");
        System.out.println(ShutdownMessage+" : Shutdown the server.");
//        System.out.print("Encode Enter a sentence(less than 256 characters): ");
        while(true){
            System.out.print("Enter a sentence(less than 256 characters): ");
            sentence = inFromUser.readLine();

            if (sentence.length()> 256){
                System.out.println("The sentence is longer than 256. Slice the sentence.");
                continue;
            }
            if ((SentenceParser(sentence) ==1))
                break;
            outToServer.writeBytes(sentence + '\n');
            ReceivedSentence = inFromServer.readLine();
            System.out.println("From Server: " + ReceivedSentence);
        }

        outToServer.writeBytes(ShutdownMessage + '\n');
        inFromUser.close();
        inFromServer.close();
        outToServer.close();
        clientSocket.close();

//        sentence = inFromUser.readLine();
//        System.out.println("Input:" + sentence);
//        outToServer.writeBytes(sentence + '\n');
//        ReceivedSentence = inFromServer.readLine();
//        System.out.println("FROM SERVER: " + ReceivedSentence);
//        clientSocket.close();
    }

    int SentenceParser(String sentence){
//        System.out.println("Input:" + sentence);
        if (sentence.equals(ShutdownMessage))
            return 1;
        else return 0;
//        else if (sentence.equals("--\'"))
//            return;
//        else if (sentence.equals("--\'"))
//            return;
    }

}
