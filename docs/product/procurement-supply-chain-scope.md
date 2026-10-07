<!--
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
-->

# Procurement & Supply Chain Product Scope

**Status:** Research-informed capability map for Neytra Console  
**Purpose:** Define the breadth of enterprise procurement and supply-chain experiences represented by the UI.  
**UI principle:** Business users see business operations, policies, KPIs, approvals, evidence, and connected systems—not internal runtime mechanics.

## Research basis

The scope was cross-checked against current enterprise procurement and supply-chain product categories and capabilities from:

- SAP / Microsoft Dynamics 365 Supply Chain Management
- Oracle Fusion Cloud Procurement
- Ivalua Source-to-Pay and Source-to-Contract
- JAGGAER spend analytics and Source-to-Pay
- Kinaxis supply-chain planning
- o9 integrated business planning and supply-chain planning
- Blue Yonder planning / warehouse / transportation
- Manhattan Active warehouse and supply-chain execution
- project44 logistics visibility / transportation / yard
- e2open planning / supply / global trade / logistics

Representative public sources:

- https://www.microsoft.com/en-in/dynamics-365/products/supply-chain-management
- https://learn.microsoft.com/en-us/dynamics365/release-plan/2026wave1/enterprise-resource-planning/dynamics365-supply-chain-management/
- https://docs.oracle.com/en/cloud/saas/procurement/26b/oapro/implement-procurement.html
- https://www.ivalua.com/solutions/process/source-to-pay-platform/
- https://www.ivalua.com/solutions/process/source-to-contract/
- https://www.ivalua.com/solutions/process/strategic-sourcing/spend-analysis/
- https://www.jaggaer.com/solutions/spend-analytics
- https://www.kinaxis.com/en
- https://o9solutions.com/solutions
- https://blueyonder.com/solutions/supply-chain-planning
- https://www.manh.com/en-in/our-solutions/supply-chain-management-software/warehouse-management-system
- https://www.project44.com/platform/
- https://www.e2open.com/platform-solutions/

## Capability domains

### Procurement intake and spend

- request / intake orchestration
- spend aggregation, cleansing, classification, and normalization
- spend visibility across business units, currencies, ERPs, P-cards, travel, and AP sources
- maverick / off-contract spend detection
- supplier fragmentation and consolidation analysis
- price variance and leakage analysis
- savings opportunity discovery
- savings initiative tracking
- category planning and category intelligence
- tail-spend optimization

### Strategic sourcing

- RFIs, RFQs, RFPs
- sourcing project plans and milestones
- supplier invitation and qualification
- bid normalization and comparison
- e-auctions
- multi-round negotiations
- scenario-based award analysis
- total-cost evaluation
- award approvals
- sourcing savings tracking

### Supplier lifecycle

- supplier discovery
- onboarding
- qualification
- master-data validation
- duplicate detection
- certificates and document collection
- supplier performance scorecards
- OTIF, quality, lead-time, responsiveness
- risk and resilience monitoring
- ESG / sustainability / diversity attributes
- supplier collaboration
- supplier portal / engagement
- multi-tier supplier visibility

### Contract lifecycle

- contract authoring and review
- clause and deviation review
- approval routing
- source-contract linkage
- obligations
- renewal / expiry management
- pricing and commercial term compliance
- contract coverage and leakage
- post-signature monitoring

### Procure-to-order

- guided buying
- catalogs
- punchout
- requisitions
- budget checks
- approval workflows
- purchase orders
- blanket / framework agreements
- PO confirmations
- PO change management
- cancellations
- goods / service receipt
- ASN collaboration
- direct-material procurement
- services procurement

### Planning

- demand forecasting
- demand sensing
- collaborative demand planning
- S&OP / IBP
- supply planning
- MRP
- capacity planning
- constrained planning
- production planning / scheduling
- order promising
- allocation
- distribution requirements planning
- scenario / what-if planning
- financial reconciliation of plans
- exception-driven replanning

### Inventory

- inventory visibility
- safety-stock policy
- multi-echelon inventory optimization
- days-of-supply policy
- replenishment
- stockout risk
- excess / obsolete risk
- inventory rebalancing
- cycle count insights
- allocation
- shortage management
- substitution and alternate-source options
- service-level optimization

### Warehouse and fulfillment

- inbound receiving
- put-away
- slotting
- picking
- packing
- shipping
- wave / workload management
- labor visibility
- cycle counting
- material-handling integration
- warehouse backlog / congestion
- order fulfillment status

### Transportation and logistics

- transportation planning
- rate comparison
- carrier selection
- tendering
- routing
- load planning
- parcel / linehaul coordination
- multimode shipment visibility
- predictive ETA
- carrier performance
- freight cost analytics
- port / lane / facility exception monitoring
- appointment management
- yard and dock management
- last-mile / e-commerce logistics
- reverse logistics

### Global trade and quality

- customs documentation
- screening
- classification
- duties
- trade compliance
- certificates
- quality inspection
- sample / quality records
- quarantine / release
- temperature / cold-chain monitoring
- controlled shipment evidence

### Network and resilience

- control tower
- network risk
- supplier / material / lane exposure
- network design
- site / lane / capacity scenarios
- dual-source analysis
- contingency options
- disruption impact
- scenario comparison
- sustainability / emissions signals

## Connector coverage

### Enterprise and procurement systems

SAP S/4HANA, SAP Ariba, Oracle Fusion, Coupa, Ivalua, JAGGAER, Dynamics 365 Supply Chain Management, NetSuite, Infor, Workday.

### Planning and execution systems

SAP IBP, Kinaxis, o9, Blue Yonder, Manhattan Active, Oracle WMS/TMS, e2open, project44, FourKites, Descartes.

### Commerce and logistics network

Salesforce, Shopify, Amazon Seller Central, carrier APIs, EDI/AS2, SFTP/FTP, REST APIs.

### Data and collaboration

Microsoft 365, Google Workspace, SharePoint, OneDrive, Google Drive, Box, Slack, Teams, Snowflake, Databricks, PostgreSQL, SQL Server, MySQL, Amazon S3, Azure Blob, Google Cloud Storage.

### Local machine and private network

The UI should support a customer-managed local connectivity category with explicit user/admin authorization and scoped access:

- Neytra Local Bridge
- approved local folders
- SMB / NFS network shares
- approved desktop applications
- local / on-prem databases through ODBC / JDBC
- private REST / HTTP endpoints
- local SFTP / FTP
- CSV / Excel watch folders
- scanners / printers where a workflow requires them
- on-prem ERP adapters

Local access should be shown as a business connector, not as unrestricted machine access.

## Category-adaptive design rule

The primary shell remains consistent across business categories. Each category supplies its own:

- dashboard KPIs
- solutions
- workflows
- configurations
- connectors
- approvals
- evidence
- analytics
- users / roles
- usage view

This allows Finance & Accounting, Procurement & Supply Chain, Customer Support, Sales, HR, IT Operations, and Legal / Compliance to share the same product without forcing one category's terminology onto another.
