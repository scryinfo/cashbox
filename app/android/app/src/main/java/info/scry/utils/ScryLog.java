package info.scry.utils;

import android.annotation.SuppressLint;
import android.content.Context;
import java.text.SimpleDateFormat;
import android.os.Build;
import android.os.Environment;
import android.util.Log;

import androidx.annotation.RequiresApi;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

public class ScryLog {

    private static Boolean MYLOG_SWITCH = true; // Log file master switch
    private static Boolean MYLOG_WRITE_TO_FILE = true;// Log write file switch
    private static char MYLOG_TYPE = 'v';// Enter the log type, w means to output only alarm information, etc., v means to output all information
    private static String MYLOG_PATH_SDCARD_DIR = "/sdcard/cashbox/log";// The path of the log file in the sdcard
    private static int SDCARD_LOG_FILE_SAVE_DAYS = 0;// Maximum number of days to save log files in sd card
    private static String MYLOGFILEName = "Log.txt";// The name of the log file output by this class
    @SuppressLint("NewApi")
    private static SimpleDateFormat myLogSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//
    // Log output format
    @SuppressLint("NewApi")
    private static SimpleDateFormat logfile = new SimpleDateFormat("yyyy-MM-dd");// Log file format
    public Context context;

    public static void w(String tag, Object msg) { // Warning message
        log(tag, msg.toString(), 'w');
    }

    public static void e(String tag, Object msg) { // Error message
        log(tag, msg.toString(), 'e');
    }

    public static void d(String tag, Object msg) {// Debug information
        log(tag, msg.toString(), 'd');
    }

    public static void i(String tag, Object msg) {//
        log(tag, msg.toString(), 'i');
    }

    public static void v(String tag, Object msg) {
        log(tag, msg.toString(), 'v');
    }

    public static void w(String tag, String text) {
        log(tag, text, 'w');
    }

    public static void e(String tag, String text) {
        log(tag, text, 'e');
    }

    public static void d(String tag, String text) {
        log(tag, text, 'd');
    }

    public static void i(String tag, String text) {
        log(tag, text, 'i');
    }

    public static void v(String tag, String text) {
        log(tag, text, 'v');
    }

    /**
     * According to tag, msg and level, output log
     *
     * @param tag
     * @param msg
     * @param level
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    private static void log(String tag, String msg, char level) {
        if (MYLOG_SWITCH) {//Log file master switch
            if ('e' == level && ('e' == MYLOG_TYPE || 'v' == MYLOG_TYPE)) { // Output error message
                Log.e(tag, msg);
            } else if ('w' == level && ('w' == MYLOG_TYPE || 'v' == MYLOG_TYPE)) {
                Log.w(tag, msg);
            } else if ('d' == level && ('d' == MYLOG_TYPE || 'v' == MYLOG_TYPE)) {
                Log.d(tag, msg);
            } else if ('i' == level && ('d' == MYLOG_TYPE || 'v' == MYLOG_TYPE)) {
                Log.i(tag, msg);
            } else {
                Log.v(tag, msg);
            }
            if (MYLOG_WRITE_TO_FILE)//Log write file switch
                writeLogtoFile(String.valueOf(level), tag, msg);
        }
    }

    /**
     * Open the log file and write to the log
     *
     * @param mylogtype
     * @param tag
     * @param text
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    private static void writeLogtoFile(String mylogtype, String tag, String text) {// Create or open a log file
        Date nowtime = new Date();
        String needWriteFiel = logfile.format(nowtime);
        String needWriteMessage = myLogSdf.format(nowtime) + "    " + mylogtype + "    " + tag +
                "    " + text;
        File dirPath = Environment.getExternalStorageDirectory();

        File dirsFile = new File(MYLOG_PATH_SDCARD_DIR);
        if (!dirsFile.exists()) {
            dirsFile.mkdirs();
        }
        //Log.i("Create a file","Create a file");
        File file = new File(dirsFile.toString(), needWriteFiel + MYLOGFILEName);//
        //Log.d("ScryLog================>", file.getAbsolutePath());
        // MYLOG_PATH_SDCARD_DIR
        if (!file.exists()) {
            try {
                //Create a file in the specified folder
                file.createNewFile();
            } catch (Exception e) {
            }
        }

        try {
            FileWriter filerWriter = new FileWriter(file, true);// The latter parameter represents whether you want to connect to the original data in the file, without overwriting
            BufferedWriter bufWriter = new BufferedWriter(filerWriter);
            bufWriter.write(needWriteMessage);
            bufWriter.newLine();
            bufWriter.close();
            filerWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Delete the specified log file
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    public static void delFile() {// Delete log files
        String needDelFiel = logfile.format(getDateBefore());
        File dirPath = Environment.getExternalStorageDirectory();
        File file = new File(dirPath, needDelFiel + MYLOGFILEName);// MYLOG_PATH_SDCARD_DIR
        if (file.exists()) {
            file.delete();
        }
    }

    /**
     * Get the date a few days before the current time, used to get the log file name that needs to be deleted
     */
    private static Date getDateBefore() {
        Date nowtime = new Date();
        Calendar now = Calendar.getInstance();
        now.setTime(nowtime);
        now.set(Calendar.DATE, now.get(Calendar.DATE) - SDCARD_LOG_FILE_SAVE_DAYS);
        return now.getTime();
    }
}