# hollyapp-logger
Snapshots and graphs for your to-do list on [https://hollyapp.com/][1]

## User stories
- I use [hollyapp][1] and I have some concerns:
    1. I'm going to accidentally delete a big chunk of the tree
    2. Someone stumbles upon my tree ID and unintentionally vandalizes it
    3. I want to see how my TODO list has been progressing over time
    4. I want to see what time (even approximately) I finished a task
- All of these issues can be resolved with keeping the tree in version control...
    - ...but I really like the webapp
    - ...sync issues would be annoying
- Actual solution: poll the tree (every minute) and commit to version control

## Goals
- v0.1:
    - I can set up a cron job to run `hollyapp-logger.sh update <treeName>`
- v0.2:
    - ...and follow up with ` && hollyapp-logger statGen html` for stats that don't need history history traversal per-query
- v0.3:
    - Stats that DO need history history traversal per-query get generated on demand

## TODO
- [x] A script to get around the accept-cookies page since `curl https://hollyapp.com/n/dmFzLmltL3dpbi8K` doesn't work anymore
- [x] A script to git-commit the list if it's changed
    - [x] For each git branch `curl` into `treeID.todo`
        - [x] Stash timestamp in `holly.time` for git to use
    - [x] Set commit datetime to what the server said
        - [x] Is there a timestamp in the HTTP response? That would be ideal. Otherwised UTC.
            - So, there are two datetimes you get back:
                - Date: Thu, 10 Dec 2020 22:02:51 GMT
                - Content-Disposition: attachment; filename="TODO_2020-12-10_23-02-52.txt"
            - According to someone on the Internet: "Neither UTC nor GMT ever change for Daylight Saving Time"
            - Why then is the "Content-Disposition" 1hr ahead? 🤔
            - Whatever, `date --date="Thu, 10 Dec 2020 22:02:51 GMT" +"%s"` outputs `1607637771`
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
