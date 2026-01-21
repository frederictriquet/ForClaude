$ cd <your-project>
$ claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project $(pwd)

Then run Claude CLI. Run /status command to see Serena MCP stuff.
> /status
A dashboard should pop in your browser
Ask Claude to start onboarding
> start Serena Onboarding

Then, ensure all the files are indexed
$ uvx --from git+https://github.com/oraios/serena serena project index