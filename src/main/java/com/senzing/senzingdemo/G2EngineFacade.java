package com.senzing.senzingdemo;

import com.senzing.g2.engine.G2Engine;
import com.senzing.g2.engine.G2JNI;
import org.springframework.stereotype.Service;

import javax.annotation.PreDestroy;

@Service
public class G2EngineFacade {

  private static final String MODULE_NAME = "testProject";

  private final G2Engine engine;

  public G2EngineFacade() {
    engine = new G2JNI();

    String iniFileName = getInitFileLocation();
    boolean verboseLogging = false;
    System.out.println("Starting engine");
    int result = engine.init(MODULE_NAME, iniFileName, verboseLogging);
    if (result != 0) {
      throw new IllegalStateException("Failed to initialize engine " + engine.getLastException());
    }
    System.out.println("Engine started successfully");
  }

  @PreDestroy
  public void shutDown() {
    System.out.println("Stopping engine");
    int destroyResult = engine.destroy();
    System.out.println("Engine stopped with code: " + destroyResult);
  }

  public String stats() {
    return engine.stats();
  }

  public String exportConfig() {
    StringBuffer response = new StringBuffer();
    int resultCode = engine.exportConfig(response);
    checkForError(resultCode, "exportConfig");
    return response.toString();
  }

  public void addRecord(String dataSourceCode, String recordID, String record) {
    int resultCode = engine.addRecord(dataSourceCode, recordID, record, null);
    checkForError(resultCode, "addRecord");
  }

  public String addRecordWithReturnedRecordID(String dataSourceCode, String record) {
    StringBuffer recordID = new StringBuffer();
    int resultCode = engine.addRecordWithReturnedRecordID(dataSourceCode, recordID, record, null);
    checkForError(resultCode, "addRecordWithReturnedRecordID");
    return recordID.toString();
  }

  public void deleteRecord(String dataSourceCode, String recordID) {
    int resultCode = engine.deleteRecord(dataSourceCode, recordID, null);
    checkForError(resultCode, "deleteRecord");
  }

  public void replaceRecord(String dataSourceCode, String recordID, String jsonData) {
    int resultCode = engine.replaceRecord(dataSourceCode, recordID, jsonData, null);
    checkForError(resultCode, "replaceRecord");
  }

  public String getRecord(String dataSourceCode, String recordID) {
    StringBuffer response = new StringBuffer();
    int resultCode = engine.getRecord(dataSourceCode, recordID, response);
    checkForError(resultCode, "getRecord");
    return response.toString();
  }

  public String getEntityByEntityID(long entityID) {
    StringBuffer response = new StringBuffer();
    int resultCode = engine.getEntityByEntityID(entityID, response);
    checkForError(resultCode, "getEntityByEntityID");
    return response.toString();
  }

  public String getEntityByRecordID(String dataSourceCode, String recordID) {
    StringBuffer response = new StringBuffer();
    int resultCode = engine.getEntityByRecordID(dataSourceCode, recordID, response);
    checkForError(resultCode, "getEntityByRecordID");
    return response.toString();
  }

  public String searchByAttributes(String jsonData) {
    StringBuffer response = new StringBuffer();
    int resultCode = engine.searchByAttributes(jsonData, response);
    checkForError(resultCode, "searchByAttributes");
    return response.toString();
  }

  public void purgeRepository() {
    int resultCode = engine.purgeRepository();
    checkForError(resultCode, "purgeRepository");
  }

  private String getInitFileLocation() {
    final String osName = System.getProperty("os.name");
    if (osName.startsWith("Windows")) {
      return "\\senzing\\g2\\python\\G2Module.ini";
    }
    else {
      return "/opt/senzing/g2/python/G2Module.ini";
    }
  }

  private void checkForError(int resultCode, String failedAction) {
    if (resultCode != 0) {
      String lastException = engine.getLastException();
      engine.clearLastException();
      throw new IllegalStateException("Failed during " + failedAction + " " + lastException);
    }
  }
}
