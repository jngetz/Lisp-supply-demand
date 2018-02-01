;;PRE:  inventory as inventory type and demand as a list of pairs (IID R) where
;;      R is the number of items requested
;;POST: RV = final output type
(defun fillOrder (inventory demand)
  ;; pass
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

;;PRE:  inventory as inventory type
;;      item_demand is a pair (IID R) where R is the number of items requested
;;POST: RV = final output type
(defun fillItemOrder (inventory item_demand)
  ;; pass
)

;;PRE:  iid exists in the inventory type and sortedInventory is inventory type
;;      sorted in descending order
;;POST: RV = inventory type where all IID = iid
(defun getWarehouses (iid sortedInventory)
  ;; pass
)

;;PRE:  inventory type and a warehouse which equals (IID WID CS MS CPI PPI)
;;POST: RV = inventory type where warehouse is in inventory
(defun addWarehouse (inventory warehouse)
  ;; pass
)

;;PRE:  inventory type
;;POST: RV = inventory type sorted in descending order
(defun inventorySort (inventory)
  ;; pass
)

;;PRE:  warehouse which equals (IID WID CS MS CPI PPI)
;;POST: RV = PPI iff CS < MS, otherwise PPI-CPI
(defun calcNetProfit (warehouse)
  ;; pass
)

;;PRE:  inventory type
;;POST: RV = sum of stock in inventory type
(defun sumStock (inventory)
  ;; pass
)

;;PRE:  inventory type and R, the number of items requested
;;POST: RV = final output type
(defun shipStock (inventory request)
  ;; pass
)
