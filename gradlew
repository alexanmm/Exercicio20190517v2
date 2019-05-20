/*
 * Copyright (C) 2006 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.os;

import android.annotation.NonNull;
import android.annotation.Nullable;
import android.util.Log;
import android.util.Printer;

import java.lang.reflect.Modifier;

/**
 * A Handler allows you to send and process {@link Message} and Runnable
 * objects associated with a thread's {@link MessageQueue}.  Each Handler
 * instance is associated with a single thread and that thread's message
 * queue.  When you create a new Handler, it is bound to the thread /
 * message queue of the thread that is creating it -- from that point on,
 * it will deliver messages and runnables to that message queue and execute
 * them as they come out of the message queue.
 * 
 * <p>There are two main uses for a Handler: (1) to schedule messages and
 * runnables to be executed as some point in the future; and (2) to enqueue
 * an action to be performed on a different thread than your own.
 * 
 * <p>Scheduling messages is accomplished with the
 * {@link #post}, {@link #postAtTime(Runnable, long)},
 * {@link #postDelayed}, {@link #sendEmptyMessage},
 * {@link #sendMessage}, {@link #sendMessageAtTime}, and
 * {@link #sendMessageDelayed} methods.  The <em>post</em> versions allow
 * you to enqueue Runnable objects to be called by the message queue when
 * they are received; the <em>sendMessage</em> versions allow you to enqueue
 * a {@link Message} object containing a bundle of data that will be
 * processed by the Handler's {@link #handleMessage} method (requiring that
 * you implement a subclass of Handler).
 * 
 * <p>When posting or sending to a Handler, you can either
 * allow the item to be processed as soon as the message queue is ready
 * to do so, or specify a delay before it gets processed or absolute time for
 * it to be processed.  The latter two allow you to implement timeouts,
 * ticks, and other timing-based behavior.
 * 
 * <p>When a
 * process is created for your application, its main thread is dedicated to
 * running a message queue that takes care of managing the top-level
 * application objects (activities, broadcast receivers, etc) and any windows
 * they create.  You can create your own threads, and communicate back with
 * the main application thread through a Handler.  This is done by calling
 * the same <em>post</em> or <em>sendMessage</em> methods as before, but from
 * your new thread.  The given Runnable or Message will then be scheduled
 * in the Handler's message queue and processed when appropriate.
 */
public class Handler {
    /*
     * Set this flag to true to detect anonymous, local or member classes
     * that extend this Handler class and that are not static. These kind
     * of classes can potentially create leaks.
     */
    private static final boolean FIND_POTENTIAL_LEAKS = false;
    private static final String TAG = "Handler";
    private static Handler MAIN_THREAD_HANDLER = null;

    /**
     * Callback interface you can use when instantiating a Handler to avoid
     * having to implement your own subclass of Handler.
     *
     * @param msg A {@link android.os.Message Message} object
     * @return True if no further handling is desired
     */
    public interface Callback {
        public boolean handleMessage(Message msg);
    }
    
    /**
     * Subclasses must implement this to receive messages.
     */
    public void handleMessage(Message msg) {
    }
    
    /**
     * Handle system messages here.
     */
    public void dispatchMessage(Message msg) {
        if (msg.callback != null) {
            handleCallback(msg);
        } else {
            if (mCallback != null) {
                if (mCallback.handleMessage(msg)) {
                    return;
                }
            }
            handleMessage(msg);
        }
    }

    /**
     * Default constructor associates this handler with the {@link Looper} for the
     * current thread.
     *
     * If this thread does not have a looper, this handler won't be able to receive messages
     * so an exception is thrown.
     */
    public Handler() {
        this(null, false);
    }

    /**
     * Constructor associates this handler with the {@link Looper} for the
     * current thread and takes a callback interface in which you can handle
     * messages.
     *
     * If this thread does not have a looper, this handler won't be able to receive messages
     * so an exception is thrown.
     *
     * @param callback The callback interface in which to handle messages, or null.
     */
    public Handler(Callback callback) {
        this(callback, false);
    }

    /**
     * Use the provided {@link Looper} instead of the default one.
     *
     * @param looper The looper, must not be 