(load "helper.el")

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

;;PRE:  inventory type and R, the number of items requested
;;POST: RV = final output type
(defun shipStock (inventory request)
  ;; pass
)