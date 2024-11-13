/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MSFRAGGER_ADAPTED }            from '../nf-modules/modules/msfragger_adapted/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow MSFRAGGERADAPTED {

    take:
    ident_files

    main:
    //
    // SUBMODULE: adapt the MSFragger result
    //
    MSFRAGGER_ADAPTED('01', ident_files)

    // return channels
    ch_ofile         = MSFRAGGER_ADAPTED.out.ofile

    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/
