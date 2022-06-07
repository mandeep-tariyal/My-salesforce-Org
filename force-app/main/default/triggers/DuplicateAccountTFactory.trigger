trigger DuplicateAccountTFactory on Account (before insert,before update,after update) {

    System.debug('inside Trigger');
    TriggerDispatcher.Run(new AccountTriggerHandler());
}