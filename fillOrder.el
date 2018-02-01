(load "fillItemOrder.el")

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
  ;; pass
)

;;PRE:  log and purchase are both final output type
;;POST: RV = final output type which includes all elements included in log and
;;           purchase
(defun mergeLog (log purchase)
  ;; pass
)
