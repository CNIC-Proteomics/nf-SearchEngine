/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DECOY_PY_RAT }            from '../nf-modules/modules/decoypyrat/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow DECOYPYRAT {

    take:
    tag_order
    add_decoys
    database
    decoy_prefix

    main:
    //
    // SUBMODULE: obtain the decoy fasta file
    //

    // optional process that depens on the given flag variable
    if ( add_decoys ) {
        DECOY_PY_RAT(tag_order, database, decoy_prefix)

        target_decoy   = DECOY_PY_RAT.out.ofile
        target         = DECOY_PY_RAT.out.ofile_target
        decoy          = DECOY_PY_RAT.out.ofile_decoy
    }
    // does not execute the process, the output is the same than input
    else {
        target_decoy   = database
        target         = Channel.empty()
        decoy          = Channel.empty()
    }

    // return channels
    emit:
    target_decoy
    target
    decoy
}

/*
========================================================================================
    THE END
========================================================================================
*/
