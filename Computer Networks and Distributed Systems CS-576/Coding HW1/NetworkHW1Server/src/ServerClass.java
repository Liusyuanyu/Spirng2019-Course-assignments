import java.io.*;
import java.net.*;

class ServerClass {

    //region Indication
    String EncodeMessage = "--Encode";
    String DecodeMessage = "--Decode";
    String ShutdownMessage = "--Shutdown";
    //endregion


    void ServerStart() throws Exception {
        String clientSentence =null;
        String SendToClientSentence;
        ServerSocket welcomeSocket = new ServerSocket(9576);
        String newStr;
        Boolean EncodeFlag = true;

        Socket connectionSocket = welcomeSocket.accept();
        BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
        DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());

        while (true) {
            clientSentence = inFromClient.readLine();
            if (clientSentence.equals(ShutdownMessage))
                break;
            else if(clientSentence.equals(EncodeMessage)){
                EncodeFlag = true;
                newStr="Now, it's available to encode sentences.";
            }
            else if(clientSentence.equals(DecodeMessage)){
                EncodeFlag = false;
                newStr="Now, it's available to decode sentences.";
            }
            else {
                System.out.println("Received: " + clientSentence);
                if (EncodeFlag)
                    newStr = StringEncoder(clientSentence);
                else
                    newStr = StringDecoder(clientSentence);
                System.out.println("Convert: " + newStr);
            }

            SendToClientSentence = newStr + '\n';
            outToClient.writeBytes(SendToClientSentence);
        }
        inFromClient.close();
        outToClient.close();
        connectionSocket.close();

    }
    String StringEncoder(String input){
        String NewStr = "";
        char NewChar ;
        char achar ;

        for (int index =0; index<input.length();index++){
            achar = input.charAt(index);
            if ((int)achar == 255)
                NewChar = (char)0;
            else NewChar = (char)((achar)+1);
//            (NewStr).concat(NewChar);
            NewStr += NewChar;
        }
        return NewStr;
    }
    String StringDecoder(String input){
        String NewStr = "";
        char NewChar ;
        char achar ;

        for (int index =0; index<input.length();index++){
            achar = input.charAt(index);
            if ((int)achar == 0)
                NewChar = (char)255;
            else NewChar = (char)((achar)-1);
            NewStr += NewChar;
        }
        return NewStr;
    }


    void ServerStart_BK() throws Exception {
        String clientSentence =null;
        String capitalizedSentence;
        ServerSocket welcomeSocket = new ServerSocket(6789);
        int timeout = 20;
        int count =0;
        while (true) {
            Socket connectionSocket = welcomeSocket.accept();
            BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
            DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
            clientSentence = inFromClient.readLine();
//            while (clientSentence == null) {
//                TimeUnit.MILLISECONDS.sleep(100);
//                clientSentence = inFromClient.readLine();
//                if (count++ == timeout)
//                    return;
//            }
            if (clientSentence.equals("shutdown"))
                break;
//            clientSentence = inFromClient.readLine();
            System.out.println("Received: " + clientSentence);
            capitalizedSentence = clientSentence.toUpperCase() + '\n';
            outToClient.writeBytes(capitalizedSentence);

//            TimeUnit.SECONDS.sleep(1);
        }
    }

}
