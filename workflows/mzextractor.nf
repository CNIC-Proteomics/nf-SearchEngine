/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MZ_EXTRACTOR }            from '../nf-modules/modules/mz_extractor/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow MZEXTRACTOR {

    take:
    ident_files
    mzml_files
    reporter_ion_isotopic

    main:
    //
    // SUBMODULE: execute MZ_extractor
    //

    // create a list of tuples with the base name and the file name.
    // This channels is a list of channels (collect()), we have to flatten the list
    ident_files
        // .flatten()
        .map{  file -> tuple(file.baseName, file) }
        // .view()
        .set { ident_files }

    // create a list of tuples with the base name and the file name.
    mzml_files
        .map { file -> tuple(file.baseName, file) }
        // .view()
        .set { mzml_files }

    // join both channels based on the first element (base name)
    ident_files
        .join(mzml_files)
        .map { name, ident, mzml -> [ident, mzml] }
        // .view { "value: $it" }
        .set { ident_quant }

    // execute the process
    MZ_EXTRACTOR('01', ident_quant, reporter_ion_isotopic)

    // return channels
    ch_ofile         = MZ_EXTRACTOR.out.ofile

    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/
