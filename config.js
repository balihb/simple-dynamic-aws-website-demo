// https://docs.renovatebot.com/configuration-options/

module.exports = {
    onboarding: true,
    onboardingConfigFileName: 'renovate.json5',
    platform: 'github',
    repositories: ['balihb/simple-dynamic-aws-website-demo'],
    repositoryCache: 'enabled',
    hostRules: [
        {
            matchHost: 'pypi.org',
            enableHttp2: true,
        },
    ],
    exposeAllEnv: true,
    customEnvVariables: {
        FORCE_COLOR: '0',
    },
}
