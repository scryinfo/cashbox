package info.scry.wallet_manager;

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

public class ScryWalletLog {

    private static Boolean MYLOG_SWITCH = true; // 日志文件总开关
    private static Boolean MYLOG_WRITE_TO_FILE = true;// 日志写入文件开关
    private static char MYLOG_TYPE = 'v';// 输入日志类型，w代表只输出告警信息等，v代表输出所有信息
    private static String MYLOG_PATH_SDCARD_DIR = "/sdcard/cashbox/log";// 日志文件在sdcard中的路径
    private static int SDCARD_LOG_FILE_SAVE_DAYS = 0;// sd卡中日志文件的最多保存天数
    private static String MYLOGFILEName = "wallet_log.txt";// 本类输出的日志文件名称
    @SuppressLint("NewApi")
    private static SimpleDateFormat myLogSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//
    // 日志的输出格式
    @SuppressLint("NewApi")
    private static SimpleDateFormat logfile = new SimpleDateFormat("yyyy-MM-dd");// 日志文件格式
    public Context context;

    public static void w(Context context, String tag, Object msg) { // 警告信息
        log(context, tag, msg.toString(), 'w');
    }

    public static void e(Context context, String tag, Object msg) { // 错误信息
        log(context, tag, msg.toString(), 'e');
    }

    public static void d(Context context, String tag, Object msg) {// 调试信息
        log(context, tag, msg.toString(), 'd');
    }

    public static void i(Context context, String tag, Object msg) {//
        log(context, tag, msg.toString(), 'i');
    }

    public static void v(Context context, String tag, Object msg) {
        log(context, tag, msg.toString(), 'v');
    }

    public static void w(Context context, String tag, String text) {
        log(context, tag, text, 'w');
    }

    public static void e(Context context, String tag, String text) {
        log(context, tag, text, 'e');
    }

    public static void d(Context context, String tag, String text) {
        log(context, tag, text, 'd');
    }

    public static void i(Context context, String tag, String text) {
        log(context, tag, text, 'i');
    }

    public static void v(Context context, String tag, String text) {
        log(context, tag, text, 'v');
    }

    /**
     * 根据tag, msg和等级，输出日志
     *
     * @param tag
     * @param msg
     * @param level
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    private static void log(Context context, String tag, String msg, char level) {
        if (MYLOG_SWITCH) {//日志文件总开关
            if ('e' == level && ('e' == MYLOG_TYPE || 'v' == MYLOG_TYPE)) { // 输出错误信息
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
            if (MYLOG_WRITE_TO_FILE)//日志写入文件开关
                writeLogtoFile(context, String.valueOf(level), tag, msg);
        }
    }

    /**
     * 打开日志文件并写入日志
     *
     * @param mylogtype
     * @param tag
     * @param text
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    private static void writeLogtoFile(Context context, String mylogtype, String tag, String text) {// 新建或打开日志文件
        Date nowtime = new Date();
        String needWriteFiel = logfile.format(nowtime);
        String needWriteMessage = myLogSdf.format(nowtime) + "    " + mylogtype + "    " + tag + "    " + text;
        File dirPath = context.getExternalCacheDir();
        File dirsFile = new File(dirPath.getAbsolutePath() + MYLOG_PATH_SDCARD_DIR);
        try {
            if (!dirsFile.exists()) {
                dirsFile.mkdirs();
            }
        } catch (Exception e) {
            Log.e("ScryLog exception,failure to create dirsFile--->", dirsFile.getAbsolutePath() + "||" + e.toString());
            return;
        }
        File file = new File(dirsFile.toString() + "/" + needWriteFiel + MYLOGFILEName);
        if (!file.exists()) {
            try {
                //在指定的文件夹中创建文件
                file.createNewFile();
            } catch (Exception e) {
                Log.e("ScryLog exception,failure to create--->", file.getAbsolutePath() + "||" + e.toString());
                return;
            }
        }

        try {
            FileWriter filerWriter = new FileWriter(file, true);// 后面这个参数代表是不是要接上文件中原来的数据，不进行覆盖
            BufferedWriter bufWriter = new BufferedWriter(filerWriter);
            bufWriter.write(needWriteMessage);
            bufWriter.newLine();
            bufWriter.close();
            filerWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
    }

    /**
     * 删除制定的日志文件
     */
    @RequiresApi(api = Build.VERSION_CODES.N)
    public static void delFile() {// 删除日志文件
        String needDelFiel = logfile.format(getDateBefore());
        File dirPath = Environment.getExternalStorageDirectory();
        File file = new File(dirPath, needDelFiel + MYLOGFILEName);// MYLOG_PATH_SDCARD_DIR
        if (file.exists()) {
            file.delete();
        }
    }

    /**
     * 得到现在时间前的几天日期，用来得到需要删除的日志文件名
     */
    private static Date getDateBefore() {
        Date nowtime = new Date();
        Calendar now = Calendar.getInstance();
        now.setTime(nowtime);
        now.set(Calendar.DATE, now.get(Calendar.DATE) - SDCARD_LOG_FILE_SAVE_DAYS);
        return now.getTime();
    }
}