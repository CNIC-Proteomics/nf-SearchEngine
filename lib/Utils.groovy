//
// This file holds several Groovy functions that could be useful for any Nextflow pipeline
//

// @Grab(group='org.ini4j', module='ini4j', version='0.5.4')
// @Grab(group='org.apache.commons', module='commons-configuration2', version='2.9.0')

import java.io.File
import org.codehaus.groovy.runtime.StackTraceUtils

class Utils {

    //
    // Retrieves the name file without extension
    //
    public static String getBaseName(String filePath) {
        def basename = new File(filePath).getBaseName()
        return basename
    }

    static def getCurrentMethodName(){
        def marker = new Throwable()
        return StackTraceUtils.sanitize(marker).stackTrace[1].methodName
    }

    //
    // Create report (list of maps) from an INI file
    //
    static def parseIniFile(fileName) {
        def result = []
        try {
            def fileReader = new File(fileName).text
            def currentSection = null
            fileReader.split("\n").each() { line ->
                line = line.trim()
                if (line.startsWith("[")) {
                    // It's a section header
                    currentSection = line.replaceAll("\\[|\\]", "")
                } else if (line && !line.startsWith("#")) {
                    // It's a key-value pair (not empty and not a comment)
                    def keyValue = line.split('=').collect { it.split('#')[0].trim() }
                    if (currentSection) {
                        // Add the key-value pair to the current section
                        result << ['section': currentSection, 'key': keyValue[0], 'value': keyValue[1]]
                    }
                }
            }
        } catch(Exception ex) {
            println("Catching the exception: ${ex}")
            System.exit(1)
        }
        return result
    }

    //
    // Create report (map) with the parameters from the MSFragger file
    //
    static def parseMsfFile(fileName) {
        // declare variables
        def result = [:]
        // 
        try {
            def fileReader = new File(fileName).text
            def currentSection = null
            fileReader.split("\n").each() { line ->
                line = line.trim()
                if (line && !line.startsWith("#")) {
                    // It's a key-value pair (not empty and not a comment)
                    def keyValue = line.split('=').collect { it.split('#')[0].trim() }
                    def key = keyValue[0]
                    def val = keyValue[1]
                    if ( !result.containsKey(key) ) {
                        result[key] = val
                    }
                    else {
                        throw new Exception("Key '$key' is duplicated in the parameter file.")
                    }
                }
            }

        } catch(Exception ex) {
            println("ERROR:${new Object(){}.getClass().getEnclosingMethod().getName()}:$ex")
            System.exit(1)
        }

        return result
    }

    //
    // Update the INI parameter file with the provided parameters
    //
    public static String updateIniParams(ini_file, replaces) {

        ini_file = "/home/jmrodriguezc/projects/nf-ReFrag/params/SHIFTS.ini"
        ini_file = "/home/jmrodriguezc/projects/nf-ReFrag/tests/test1/params/closed_fragger.params"
        // ini_file = "/tmp/config.ini"
        println("PARAM_FILE ${ini_file}")

        def fileName = ini_file
        // parse the INI file
        def ini_data = parseIniFile(fileName)
        ini_data.each { entry ->
            println "Section: ${entry.section}, Key: ${entry.key}, Value: ${entry.value}"
        }


        return 'KK'
    }


    //
    // Update the MSFragger parameter file with the provided parameters
    //
    public static Map updateMsfParams(ifile, replaces) {

        println("PARAM_FILE ${ifile}")

        // parse the MSF file
        def ini_data = parseMsfFile(ifile.toString())
        // update the given attributes
        try {
            replaces.each { replace ->
                if ( ini_data.containsKey(replace.key) ) {
                    ini_data[replace.key] = replace.value
                }
                else {
                    throw new Exception("Key '$replace.key' is not in the parameter file.")
                }
            }
        } catch(Exception ex) {
            println("ERROR:${new Object(){}.getClass().getEnclosingMethod().getName()}:$ex")
            System.exit(1)
        }

        return ini_data
    }
}
