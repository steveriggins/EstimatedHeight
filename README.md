EstimatedHeight
===============

Radar: 16266367

Summary:
If you set up a UITableView with a delegate the implements tableView:estimatedHeightForRowAtIndexPath:, and then switch to one that does not, UITableView can crash in reloadData

Steps to Reproduce:

 1. Implement a UIViewController with a tableView
 1. Implement two NSObjects conforming to UITableVIewDataSource and UITableViewDeleegate
 1. First one implements tableView:estimatedHeightForRowAtIndexPath: for section index 1 (out of 3)
 1. Second one does not implement tableView:estimatedHeightForRowAtIndexPath:, only has two sections
 1. Set the tableView delegate/datasource to the first delegate
 1. reloadTable
 1. Tap button that sets dataSource/delegate to delegate two
 1. reloadTable
 1. crash


Expected Results:
no crash

Actual Results:

	Thread 1, Queue : com.apple.main-thread
	#0	0x00480d60 in __66-[UISectionRowData refreshWithSection:tableView:tableViewRowData:]_block_invoke ()
	#1	0x00480450 in -[UISectionRowData refreshWithSection:tableView:tableViewRowData:] ()
	#2	0x004836bd in -[UITableViewRowData numberOfRows] ()
	#3	0x0030bdb2 in -[UITableView noteNumberOfRowsChanged] ()
	#4	0x0030b75f in -[UITableView reloadData] ()
	#5	0x0f675e91 in -[UITableViewAccessibility(Accessibility) reloadData] ()
	#6	0x00002e82 in -[SRViewController reloadTable:] at /Users/vampira/Desktop/EstimatedHeight/EstimatedHeight/SRViewController.m:69
	#7	0x014d1874 in -[NSObject performSelector:withObject:withObject:] ()
	#8	0x0022f0c2 in -[UIApplication sendAction:to:from:forEvent:] ()
	#9	0x00503c9b in -[UIBarButtonItem(UIInternal) _sendAction:withEvent:] ()
	#10	0x014d1874 in -[NSObject performSelector:withObject:withObject:] ()
	#11	0x0022f0c2 in -[UIApplication sendAction:to:from:forEvent:] ()
	#12	0x0022f04e in -[UIApplication sendAction:toTarget:fromSender:forEvent:] ()
	#13	0x003270c1 in -[UIControl sendAction:to:forEvent:] ()
	#14	0x00327484 in -[UIControl _sendActionsForEvents:withEvent:] ()
	#15	0x00326733 in -[UIControl touchesEnded:withEvent:] ()
	#16	0x0026c51d in -[UIWindow _sendTouchesForEvent:] ()
	#17	0x0026d184 in -[UIWindow sendEvent:] ()
	#18	0x00240e86 in -[UIApplication sendEvent:] ()
	#19	0x0022b18f in _UIApplicationHandleEventQueue ()
	#20	0x016c583f in __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ ()
	#21	0x016c51cb in __CFRunLoopDoSources0 ()
	#22	0x016e229e in __CFRunLoopRun ()
	#23	0x016e1ac3 in CFRunLoopRunSpecific ()
	#24	0x016e18db in CFRunLoopRunInMode ()
	#25	0x036e19e2 in GSEventRunModal ()
	#26	0x036e1809 in GSEventRun ()
	#27	0x0022dd3b in UIApplicationMain ()
	#28	0x0000290d in main at /Users/vampira/Desktop/EstimatedHeight/EstimatedHeight/main.m:16

