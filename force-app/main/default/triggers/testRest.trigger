trigger testRest on Account (before insert) {

    for(account ac : trigger.new)
    {
        CloneRecordsByRest.cloneData(ac.name,ac.description);
    }
}