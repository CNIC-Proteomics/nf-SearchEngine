//
// This file holds several functions specific to the main.nf workflow in the nf-core/quantms pipeline
//

class WorkflowMain {

    //
    // Citation string for pipeline
    //
    public static String citation(workflow) {
        return "If you use ${workflow.manifest.name} for your analysis please cite:\n\n" +
            "* The nf-core framework\n" +
            "  https://doi.org/10.1038/s41587-020-0439-x\n\n" +
            "* Software dependencies\n" +
            "  https://github.com/CNIC-Proteomics/${workflow.manifest.name}/blob/main/CITATIONS.md"
    }

    //
    // Generate help string
    //
    public static String help(workflow, params, log) {
        def command = "nextflow run ${workflow.manifest.name} UNDER CONSTRUCTION"
        def help_string = ''
        help_string += NfcoreTemplate.logo(workflow, params.monochrome_logs)
        // help_string += NfcoreSchema.paramsHelp(workflow, params, command)
        help_string += '\n' + citation(workflow) + '\n'
        help_string += NfcoreTemplate.dashedLine(params.monochrome_logs)
        return help_string
    }

    //
    // Generate parameter summary log string
    //
    public static String paramsSummaryLog(workflow, params, log) {
        def summary_log = ''
        summary_log += NfcoreTemplate.logo(workflow, params.monochrome_logs)
        // summary_log += NfcoreSchema.paramsSummaryLog(workflow, params)
        summary_log += '\n' + citation(workflow) + '\n'
        summary_log += NfcoreTemplate.dashedLine(params.monochrome_logs)
        return summary_log
    }

    //
    // Validate parameters and print summary to screen
    //
    public static void initialise(workflow, params, log) {
        // Print help to screen if required
        if (params.help) {
            log.info help(workflow, params, log)
            System.exit(0)
        }

        // Print workflow version and exit on --version
        if (params.version) {
            String workflow_version = NfcoreTemplate.version(workflow)
            log.info "${workflow.manifest.name} ${workflow_version}"
            System.exit(0)
        }

        // Print parameter summary log to screen
        log.info paramsSummaryLog(workflow, params, log)

        // // Validate workflow parameters via the JSON schema
        // if (params.validate_params) {
        //     NfcoreSchema.validateParameters(workflow, params, log)
        // }

        // Check that a -profile or Nextflow config has been provided to run the pipeline
        // NfcoreTemplate.checkConfigProvided(workflow, log)

        // // Check that conda channels are set-up correctly
        // if (workflow.profile.tokenize(',').intersect(['conda', 'mamba']).size() >= 1) {
        //     Utils.checkCondaChannels(log)
        // }

        // Check AWS batch settings
        NfcoreTemplate.awsBatch(workflow, params)

        // // Check input has been provided
        // if (!params.params_file) {
        //     log.error "Please provide an parameter file to the pipeline e.g. '--params_file params.ini'"
        //     System.exit(1)
        // }

        // Check input has been provided
        if (!params.outdir) {
            log.error "Please provide an outdir to the pipeline e.g. '--outdir ./results'"
            System.exit(1)
        }

        // Create parameter dir
        def output_d = new File("${params.paramdir}")
        if (!params.paramdir.startsWith("null/")) {
            output_d.mkdirs()
        }

        // // check fasta database has been provided
        // if (!params.database) {
        //     log.error "Please provide an fasta database to the pipeline e.g. '--database *.fasta'"
        // }

        if (params.tracedir.startsWith("null/")) {
            log.error """Error: Your tracedir is `\$params.tracedir`, this means you probably set outdir in a way that does not affect the default
            `\$params.tracedir` (e.g., by specifying outdir in a profile instead of the commandline or through a `-params-file`.
            Either set outdir in a correct way, or redefine tracedir as well (e.g., in your profile)."""
            System.exit(1)
        }

    }
}
