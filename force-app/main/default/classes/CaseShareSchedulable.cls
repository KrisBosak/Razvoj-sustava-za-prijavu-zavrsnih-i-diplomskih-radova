global class CaseShareSchedulable implements Schedulable {
	global void execute(SchedulableContext sc) {
		CaseShareBatch b = new CaseShareBatch();
		database.executebatch(b, 200);
	}
}