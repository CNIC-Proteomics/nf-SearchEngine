/*
========================================================================================
    VALIDATE INPUTS
========================================================================================
*/

/*
========================================================================================
    CONFIG FILES
========================================================================================
*/


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DECOY_PY_RAT }            from '../modules/decoypyrat/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow DECOYPYRAT {

    take:
    database
    add_decoys
    decoy_prefix

    main:
    //
    // SUBMODULE: obtain the decoy fasta file
    //
    println "DATABASE: ${database}"
    println "DECOY: ${add_decoys}"
    println "PREFIX: ${decoy_prefix}"
    DECOY_PY_RAT(database, add_decoys, decoy_prefix)

    path("*.target-decoy.fasta", emit: ofile)
    path("*.target.fasta", emit: ofile_target)
    path("*.decoy.fasta", emit: ofile_decoy)

    // return channels
    ch_target_decoy   = DECOY_PY_RAT.out.ofile
    ch_target         = DECOY_PY_RAT.out.ofile_target
    ch_decoy          = DECOY_PY_RAT.out.ofile_decoy

    emit:
    target_decoy = ch_target_decoy
    target       = ch_target
    decoy        = ch_decoy
}

/*
========================================================================================
    THE END
========================================================================================
*/
