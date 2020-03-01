## Error Handling/Tracing related data
### For resort:day namespace
```
# Make it "transactional", only update the actual data on success
last_update => timestamp

# For error handling and tracking
last_update_attempt => timestamp
status => error | synced
