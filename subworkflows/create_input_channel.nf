//
// Create channel for input file
//

workflow CREATE_INFILES_CHANNEL {
    take:
    infiles

    main:
    input_files = Channel.fromPath("${infiles}", checkIfExists: true)

    emit:
    input_file         = input_files
}

workflow CREATE_INFILE_CHANNEL {
    take:
    infile

    main:
    input_file = Channel.fromPath("${infile}", checkIfExists: true)

    emit:
    input_file         = input_file
}
