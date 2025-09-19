/*
========================================================================================
    IMPORT MODULES
========================================================================================
*/

include { joinChannelsFromFilename } from '../nf-modules/lib/Utils'

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
    tag_order
    add_quant
    ident_files
    mzml_files
    reporter_ion_isotopic

    main:
    //
    // SUBMODULE: execute MZ_extractor
    //

    // optional process that depens on the given parameter variable
    if ( add_quant ) {
        
        // if reporter ion isotopic file is provided, add labeling quantification (TMT)
        if ( reporter_ion_isotopic.name.val != 'NO_FILE' ) {
            
            // join two channels based on the file name
            ident_quant_files = joinChannelsFromFilename(ident_files, mzml_files)

            // execute the process
            MZ_EXTRACTOR(tag_order, ident_quant_files, reporter_ion_isotopic)

            ch_ofile         = MZ_EXTRACTOR.out.ofile

        }
        // add label-free quantification (Label-Free)
        else {
            ch_ofile = ident_files // at the moment, does not execute the process, the output is the same than input
        }
    }
    // does not execute the process, the output is the same than input
    else {
        ch_ofile = ident_files
    }

    // return channels
    emit:
    ofile       = ch_ofile

}

/*
========================================================================================
    THE END
========================================================================================
*/
