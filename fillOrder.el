(load "fillItemOrder")

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
  (cond ((equal (length demand) 1) (fillItemOrder inventory (car demand))
	 ;; Base Case: demand only has one item, so RV is fillItemOrder of
	 ;;            that item
	 (t (mergeLog (itemIterator inventory (cdr demand))
		      (fillItemOrder inventory (car demand))))
	 ;; Recursive Case: Get results of all further items
	 ;;                 in demand and merge with the results
	 ;;                 of filling the current items order
	 )
)

;;PRE:  log and purchase are both final output type
;;POST: RV = final output type which includes all elements included in log and
;;           purchase
(defun mergeLog (log purchase)
  ;; pass
)
