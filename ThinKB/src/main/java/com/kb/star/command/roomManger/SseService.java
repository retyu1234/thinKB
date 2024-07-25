package com.kb.star.command.roomManger;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.ServletOutputStream;

public class SseService {

	   private final CopyOnWriteArrayList<ServletOutputStream> emitters = new CopyOnWriteArrayList<>();

	    public void addEmitter(ServletOutputStream emitter) {
	        emitters.add(emitter);
	    }

	    public void removeEmitter(ServletOutputStream emitter) {
	        emitters.remove(emitter);
	    }

	    public void sendNotification(String message) throws IOException {
	        for (ServletOutputStream emitter : emitters) {
	            PrintWriter writer = new PrintWriter(emitter);
				writer.write("data: " + message + "\n\n");
				writer.flush();
	        }
	    }
}
