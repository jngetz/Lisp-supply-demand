(load-file "fillItemOrder.el")

;;PRE:  inventory as inventory type and demand as a list of pairs (IID R) where
;;      R is the number of items requested
;;POST: RV = final output type
(defun fillOrder (inventory demand)
  (itemIterator inventory demand)
)

;;PRE:  inventory as inventory type and demand as a list of pairs (IID R) where
;;      R is the number of items requested
;;POST: RV = final output type
(defun itemIterator (inventory demand)
  (cond ((equal (length demand) 1) (fillItemOrder inventory (car demand)))
	 ;; Base Case: demand only has one item, so RV is fillItemOrder of
	 ;;            that item
	 (t (merge (itemIterator inventory (cdr demand))
		   (fillItemOrder inventory (car demand))))
	 ;; Recursive Case: Get results of all further items
	 ;;                 in demand and merge with the results
	 ;;                 of filling the current items order
         )
)

;;PRE:  log and purchase are both final output type
;;POST: RV = updated_log is a final output type that contains log and changes
;;      from purchase
(defun merge (log purchase)
  (append (list (mergeInventory (car log) (car purchase)))
	  ;;car FOT gives inventory types
	  (cond ((equal (cdr purchase) nil) (cdr log))
		((equal (cdr log) nil) (cdr purchase))
		(t (list (mergeWarnings (car (cdr log)) (car (cdr purchase)))))
	  )	
	  ;;car cdr FOT gives the warnings for the items below
	  ;;minimum stock
  )
)

;;PRE:  inventory and update are both inventory types
;;POST: RV = updated_inventory is an inventory type that contains the
;;      union of inventory and update
(defun mergeInventory (inventory update)
  (append inventory update)
)

;;PRE:  warnings and update are both lists of warning types
;;POST: RV = updated_warnings is the union of updated warnings from warnings,
;;      and the warnings found exlusively in warnings or update
(defun mergeWarnings (warnings update)
  (cond ((equal update nil) warnings)
	((equal warnings nil) update)
	(t (append (list (getWarningsNotIn warnings update))
		   (updateWarnings warnings update)))
  )
)

;;PRE:  warnings and update are both lists of warning types
;;POST: RV = updated_warnings is the list of warning types that are contained in
;;      warnings updated to info in update
(defun updateWarnings (warnings update)
  (cond ((equal warnings nil) nil)
	(t (append (list (mergeWarning (car warnings) update))
		   (updateWarnings (cdr warnings) update))
	)
  )
)

;;PRE:  warnings and update are both lists of warning types
;;POST: RV = updates where updates is the list of warning type objects from
;;      update where wid not in warnings
(defun getWarningsNotIn (warnings update)
  (cond ((equal update nil) nil) ;;nil is a list
	((equal (findWarning (caar update) warnings) nil)
	 ;;If wid from update isn't in warnings, add it to warnings and
	 ;;all further updates that aren't in warnings
	 (append (getWarningsNotIn warnings (cdr update))
		 (car update)))
	;; Append the update to the rest of the new warehouses
	(t (getWarningsNotIn warnings (cdr update)))
	;;If  wid is in warnings, then we don't have to update anything
	)
)

;;PRE:  warning is a warning type
;;      update is a list of inventory types
;;POST: RV = updated_warning where updated_warning is a warning type containing
;;      the union of warning and any update where wid is the same as warning
(defun mergeWarning (warning update)
  (list (car warning) (append (cadr warning)
			      ;;(cdr warning) is a list of iids
			      (cadr (findWarning (car warning) update)) ) )
                              ;;gets the list of iids from update
)

;;PRE:  wid is a positive integer
;;POST: RV = nil if no warnings exist for wid, else
;;      RV = warning type for the warehouse with wid
(defun findWarning (wid warnings)
  (cond ((equal warnings nil) nil)
	((equal wid (caar warnings)) (car warnings))
	(t (findWarning wid (cdr warnings)))
  )
)
