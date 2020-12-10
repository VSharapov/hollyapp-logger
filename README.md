# hollyapp-logger
Snapshots and graphs for your to-do list on [https://hollyapp.com/][1]

## User stories
- I use [hollyapp][1] and I have some concerns:
    1. I'm going to accidentally delete a big chunk of the tree
    2. Someone stumbles upon my tree ID and unintentionally vandalizes it
    3. I want ot see how my TODO lish has been progressing over time
    4. I want to see what time (approximately) I finished a task
- ALl of these issues can be resolved with keeping the tree in version control...
    - ...but I really like the webapp
    - ...Sync issues would be annoying
- Actual solution: poll the tree and update in VC

## Goals
- v0.1:
    - I can set up a cron job to run `hollyapp-logger.sh update <treeName>`
- v0.2:
    - ...and follow up with ` && hollyapp-logger statGen html` for stats that don't need history history traversal per-query
- v0.3:
    - Stats that DO need history history traversal per-query get generated on demand

## TODO
- [x] A script to get around the accept-cookies page since `curl https://hollyapp.com/n/dmFzLmltL3dpbi8K` doesn't work anymore
- [ ] A script to git-commit the list if it's changed
    - [ ] Make sure branch is set to `treeID`
    - [ ] `curl` into `unixTime.treeID.log`
        - [ ] Is there a timestamp in the HTTP response? That would be ideal. Otherwised UTC.
- [ ] Visualizations for the current list
- [ ] Visualizations for the list history
- [ ] Handle multiple lists as top-level branches
- [ ] Polish the `curl` script:
    - [ ] cookie options:
        - [ ] check if bad/expired & reinit
        - [ ] listID verification
        - [ ] listID from config file
    - [ ] keep `curl` logs for debugging

[1]: https://hollyapp.com/
