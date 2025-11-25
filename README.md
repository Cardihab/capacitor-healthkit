# Capacitor HealthKit Plugin

We are slowly working on the next version of this plugin. PRs to the main branch are no longer being accepted, please work with the v2 branch from now on. v2 is already being published as alpha on npm.

:heart: Capacitor plugin to retrieve data from HealthKit :heart:

Disclaimer : _for now only some of the HK data base, in the future the retrieve base will be bigger !_

## Getting Started

### Prerequisites

* Add **HealthKit to your Xcode project** (section signing & capabilities)

![alt text](https://i.ibb.co/Bg03ZKf/auth-hk.png)

* ADD **Privacy - Health Share Usage Description** to your Xcode project
* ADD **Privacy - Health Update Usage Description** to your Xcode project

You can simply put this into the `info.plist` file

```
	<key>NSHealthShareUsageDescription</key>
	<string>Read Health Data</string>
	<key>NSHealthUpdateUsageDescription</key>
	<string>Read Health Data</string>
```

### Installing

Do

```
npm i --save @perfood/capacitor-healthkit
```

Then

```
npx cap update
```

And  **if you use Ionic or Angular, here a example setup:**

in your .ts file add this:

```
import {
  ActivityData,
  CapacitorHealthkit,
  OtherData,
  QueryOutput,
  SampleNames,
  SleepData,
} from '@perfood/capacitor-healthkit';

const READ_PERMISSIONS = ['calories', 'stairs', 'activity', 'steps', 'distance', 'duration', 'weight'];

```

and then you can create async functions like this:

```


  public async requestAuthorization(): Promise<void> {
    try {
      await CapacitorHealthkit.requestAuthorization({
        all: [''],
        read: READ_PERMISSIONS,
        write: [''],
      });

    } catch (error) {
      console.error('[HealthKitService] Error getting Authorization:', error);
    }
  }

  private async getActivityData(
    startDate: Date,
    endDate: Date = new Date(),
  ): Promise<QueryOutput<ActivityData>> | undefined {
    try {
      const queryOptions = {
        sampleName: SampleNames.WORKOUT_TYPE,
        startDate: startDate.toISOString(),
        endDate: endDate.toISOString(),
        limit: 0,
      };

      return await CapacitorHealthkit.queryHKitSampleType<ActivityData>(queryOptions);
    } catch (error) {
      console.error(error);

      return undefined;
    }
  }
```

so you can use the plugin for example with the call `CapacitorHealthkit.queryHKitSampleType(...`

And you're all set ! :+1:

<docgen-index>

* [`requestAuthorization(...)`](#requestauthorization)
* [`queryHKitSampleType(...)`](#queryhkitsampletype)
* [`queryHKitSampleTypeAnchored(...)`](#queryhkitsampletypeanchored)
* [`isAvailable()`](#isavailable)
* [`multipleQueryHKitSampleType(...)`](#multiplequeryhkitsampletype)
* [`isEditionAuthorized(...)`](#iseditionauthorized)
* [`multipleIsEditionAuthorized(...)`](#multipleiseditionauthorized)
* [`queryAggregatedDailySampleType(...)`](#queryaggregateddailysampletype)
* [`queryAggregatedDailySampleTypeAnchored(...)`](#queryaggregateddailysampletypeanchored)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### requestAuthorization(...)

```typescript
requestAuthorization(authOptions: AuthorizationQueryOptions) => Promise<void>
```

This functions will open the iOS Screen to let users choose their permissions. Keep in mind as developers, if the access has been denied by the user we will have no way of knowing - the query results will instead just be empty arrays.

| Param             | Type                                                                            | Description                                                                                                                                |
| ----------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **`authOptions`** | <code><a href="#authorizationqueryoptions">AuthorizationQueryOptions</a></code> | These define which access we need. Possible Options include ['calories', 'stairs', 'activity', 'steps', 'distance', 'duration', 'weight']. |

--------------------


### queryHKitSampleType(...)

```typescript
queryHKitSampleType<T>(queryOptions: SingleQueryOptions) => Promise<QueryOutput<T>>
```

This defines a query to the Healthkit for a single type of data.

| Param              | Type                                                              | Description                                                                                                            |
| ------------------ | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **`queryOptions`** | <code><a href="#singlequeryoptions">SingleQueryOptions</a></code> | defines the type of data and the timeframe which shall be queried, a limit can be set to reduce the number of results. |

**Returns:** <code>Promise&lt;<a href="#queryoutput">QueryOutput</a>&lt;T&gt;&gt;</code>

--------------------


### queryHKitSampleTypeAnchored(...)

```typescript
queryHKitSampleTypeAnchored<T>(queryOptions: AnchoredQueryOptions) => Promise<AnchoredQueryOutput<T>>
```

This defines an anchored query to the Healthkit for a single type of data. Returns new/modified/deleted samples since the last anchor.

| Param              | Type                                                                  | Description                                                                       |
| ------------------ | --------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| **`queryOptions`** | <code><a href="#anchoredqueryoptions">AnchoredQueryOptions</a></code> | defines the type of data, timeframe, and optional anchor for incremental queries. |

**Returns:** <code>Promise&lt;<a href="#anchoredqueryoutput">AnchoredQueryOutput</a>&lt;T&gt;&gt;</code>

--------------------


### isAvailable()

```typescript
isAvailable() => Promise<{ available: boolean; }>
```

This functions resolves if HealthKitData is available it uses the native HKHealthStore.isHealthDataAvailable() function of the HealthKit.

**Returns:** <code>Promise&lt;{ available: boolean; }&gt;</code>

--------------------


### multipleQueryHKitSampleType(...)

```typescript
multipleQueryHKitSampleType(queryOptions: MultipleQueryOptions) => Promise<any>
```

This defines a query to the Healthkit for a single type of data. This function has not been tested.

| Param              | Type                                                                  | Description                                       |
| ------------------ | --------------------------------------------------------------------- | ------------------------------------------------- |
| **`queryOptions`** | <code><a href="#multiplequeryoptions">MultipleQueryOptions</a></code> | defines the sample types which can be queried for |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### isEditionAuthorized(...)

```typescript
isEditionAuthorized(queryOptions: EditionQuery) => Promise<void>
```

Checks if there is writing permission for one specific sample type. This function has not been tested.

| Param              | Type                                                  | Description                                                                |
| ------------------ | ----------------------------------------------------- | -------------------------------------------------------------------------- |
| **`queryOptions`** | <code><a href="#editionquery">EditionQuery</a></code> | defines the sampletype for which you need to check for writing permission. |

--------------------


### multipleIsEditionAuthorized(...)

```typescript
multipleIsEditionAuthorized(queryOptions: MultipleEditionQuery) => Promise<void>
```

Checks if there is writing permission for multiple sample types. This function has not been tested.

| Param              | Type                                                                  | Description                                                                 |
| ------------------ | --------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| **`queryOptions`** | <code><a href="#multipleeditionquery">MultipleEditionQuery</a></code> | defines the sampletypes for which you need to check for writing permission. |

--------------------


### queryAggregatedDailySampleType(...)

```typescript
queryAggregatedDailySampleType(options: AggregatedQueryOptions) => Promise<AggregatedQueryOutput>
```

Query aggregated daily sample data from HealthKit.

| Param         | Type                                                                      | Description                                                       |
| ------------- | ------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#aggregatedqueryoptions">AggregatedQueryOptions</a></code> | defines the sample type and the timeframe which shall be queried. |

**Returns:** <code>Promise&lt;<a href="#aggregatedqueryoutput">AggregatedQueryOutput</a>&gt;</code>

--------------------


### queryAggregatedDailySampleTypeAnchored(...)

```typescript
queryAggregatedDailySampleTypeAnchored(options: AnchoredAggregatedQueryOptions) => Promise<AnchoredAggregatedQueryOutput>
```

Query aggregated daily sample data from HealthKit with anchor support for incremental updates.

| Param         | Type                                                                                      | Description                                                                      |
| ------------- | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#anchoredaggregatedqueryoptions">AnchoredAggregatedQueryOptions</a></code> | defines the sample type, timeframe, and optional anchor for incremental queries. |

**Returns:** <code>Promise&lt;<a href="#anchoredaggregatedqueryoutput">AnchoredAggregatedQueryOutput</a>&gt;</code>

--------------------


### Interfaces


#### AuthorizationQueryOptions

Used for authorization of reading and writing access.

| Prop        | Type                  |
| ----------- | --------------------- |
| **`read`**  | <code>string[]</code> |
| **`write`** | <code>string[]</code> |
| **`all`**   | <code>string[]</code> |


#### QueryOutput

This interface is used for any results coming from HealthKit. It always has a count and the actual results.

| Prop              | Type                |
| ----------------- | ------------------- |
| **`countReturn`** | <code>number</code> |
| **`resultData`**  | <code>T[]</code>    |


#### SingleQueryOptions

This extends the Basequeryoptions for a single sample type.

| Prop             | Type                |
| ---------------- | ------------------- |
| **`sampleName`** | <code>string</code> |


#### AnchoredQueryOutput

Extended query output for anchored queries, includes anchor for next query and deleted sample UUIDs.

| Prop               | Type                  |
| ------------------ | --------------------- |
| **`anchor`**       | <code>string</code>   |
| **`deletedUUIDs`** | <code>string[]</code> |


#### AnchoredQueryOptions

Query options for anchored queries.

| Prop             | Type                |
| ---------------- | ------------------- |
| **`sampleName`** | <code>string</code> |
| **`startDate`**  | <code>string</code> |
| **`endDate`**    | <code>string</code> |
| **`anchor`**     | <code>string</code> |


#### MultipleQueryOptions

This extends the Basequeryoptions for a multiple sample types.

| Prop              | Type                  |
| ----------------- | --------------------- |
| **`sampleNames`** | <code>string[]</code> |


#### EditionQuery

This is used for checking writing permissions.

| Prop             | Type                |
| ---------------- | ------------------- |
| **`sampleName`** | <code>string</code> |


#### MultipleEditionQuery

This is used for checking writing permissions.

| Prop              | Type                  |
| ----------------- | --------------------- |
| **`sampleNames`** | <code>string[]</code> |


#### AggregatedQueryOutput

Output for aggregated queries.

| Prop             | Type                          |
| ---------------- | ----------------------------- |
| **`resultData`** | <code>AggregatedData[]</code> |


#### AggregatedData

Data structure for aggregated daily results.

| Prop            | Type                |
| --------------- | ------------------- |
| **`value`**     | <code>number</code> |
| **`startDate`** | <code>string</code> |
| **`date`**      | <code>string</code> |


#### AggregatedQueryOptions

Query options for aggregated daily data.

| Prop             | Type                                  |
| ---------------- | ------------------------------------- |
| **`sampleName`** | <code>string</code>                   |
| **`startDate`**  | <code>string</code>                   |
| **`endDate`**    | <code><a href="#date">Date</a></code> |
| **`limit`**      | <code>number</code>                   |


#### Date

Enables basic storage and retrieval of dates and times.

| Method                 | Signature                                                                                                    | Description                                                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| **toString**           | () =&gt; string                                                                                              | Returns a string representation of a date. The format of the string depends on the locale.                                              |
| **toDateString**       | () =&gt; string                                                                                              | Returns a date as a string value.                                                                                                       |
| **toTimeString**       | () =&gt; string                                                                                              | Returns a time as a string value.                                                                                                       |
| **toLocaleString**     | () =&gt; string                                                                                              | Returns a value as a string value appropriate to the host environment's current locale.                                                 |
| **toLocaleDateString** | () =&gt; string                                                                                              | Returns a date as a string value appropriate to the host environment's current locale.                                                  |
| **toLocaleTimeString** | () =&gt; string                                                                                              | Returns a time as a string value appropriate to the host environment's current locale.                                                  |
| **valueOf**            | () =&gt; number                                                                                              | Returns the stored time value in milliseconds since midnight, January 1, 1970 UTC.                                                      |
| **getTime**            | () =&gt; number                                                                                              | Gets the time value in milliseconds.                                                                                                    |
| **getFullYear**        | () =&gt; number                                                                                              | Gets the year, using local time.                                                                                                        |
| **getUTCFullYear**     | () =&gt; number                                                                                              | Gets the year using Universal Coordinated Time (UTC).                                                                                   |
| **getMonth**           | () =&gt; number                                                                                              | Gets the month, using local time.                                                                                                       |
| **getUTCMonth**        | () =&gt; number                                                                                              | Gets the month of a <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                             |
| **getDate**            | () =&gt; number                                                                                              | Gets the day-of-the-month, using local time.                                                                                            |
| **getUTCDate**         | () =&gt; number                                                                                              | Gets the day-of-the-month, using Universal Coordinated Time (UTC).                                                                      |
| **getDay**             | () =&gt; number                                                                                              | Gets the day of the week, using local time.                                                                                             |
| **getUTCDay**          | () =&gt; number                                                                                              | Gets the day of the week using Universal Coordinated Time (UTC).                                                                        |
| **getHours**           | () =&gt; number                                                                                              | Gets the hours in a date, using local time.                                                                                             |
| **getUTCHours**        | () =&gt; number                                                                                              | Gets the hours value in a <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                       |
| **getMinutes**         | () =&gt; number                                                                                              | Gets the minutes of a <a href="#date">Date</a> object, using local time.                                                                |
| **getUTCMinutes**      | () =&gt; number                                                                                              | Gets the minutes of a <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                           |
| **getSeconds**         | () =&gt; number                                                                                              | Gets the seconds of a <a href="#date">Date</a> object, using local time.                                                                |
| **getUTCSeconds**      | () =&gt; number                                                                                              | Gets the seconds of a <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                           |
| **getMilliseconds**    | () =&gt; number                                                                                              | Gets the milliseconds of a <a href="#date">Date</a>, using local time.                                                                  |
| **getUTCMilliseconds** | () =&gt; number                                                                                              | Gets the milliseconds of a <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                      |
| **getTimezoneOffset**  | () =&gt; number                                                                                              | Gets the difference in minutes between the time on the local computer and Universal Coordinated Time (UTC).                             |
| **setTime**            | (time: number) =&gt; number                                                                                  | Sets the date and time value in the <a href="#date">Date</a> object.                                                                    |
| **setMilliseconds**    | (ms: number) =&gt; number                                                                                    | Sets the milliseconds value in the <a href="#date">Date</a> object using local time.                                                    |
| **setUTCMilliseconds** | (ms: number) =&gt; number                                                                                    | Sets the milliseconds value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                              |
| **setSeconds**         | (sec: number, ms?: number \| undefined) =&gt; number                                                         | Sets the seconds value in the <a href="#date">Date</a> object using local time.                                                         |
| **setUTCSeconds**      | (sec: number, ms?: number \| undefined) =&gt; number                                                         | Sets the seconds value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                   |
| **setMinutes**         | (min: number, sec?: number \| undefined, ms?: number \| undefined) =&gt; number                              | Sets the minutes value in the <a href="#date">Date</a> object using local time.                                                         |
| **setUTCMinutes**      | (min: number, sec?: number \| undefined, ms?: number \| undefined) =&gt; number                              | Sets the minutes value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                   |
| **setHours**           | (hours: number, min?: number \| undefined, sec?: number \| undefined, ms?: number \| undefined) =&gt; number | Sets the hour value in the <a href="#date">Date</a> object using local time.                                                            |
| **setUTCHours**        | (hours: number, min?: number \| undefined, sec?: number \| undefined, ms?: number \| undefined) =&gt; number | Sets the hours value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                     |
| **setDate**            | (date: number) =&gt; number                                                                                  | Sets the numeric day-of-the-month value of the <a href="#date">Date</a> object using local time.                                        |
| **setUTCDate**         | (date: number) =&gt; number                                                                                  | Sets the numeric day of the month in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                        |
| **setMonth**           | (month: number, date?: number \| undefined) =&gt; number                                                     | Sets the month value in the <a href="#date">Date</a> object using local time.                                                           |
| **setUTCMonth**        | (month: number, date?: number \| undefined) =&gt; number                                                     | Sets the month value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                     |
| **setFullYear**        | (year: number, month?: number \| undefined, date?: number \| undefined) =&gt; number                         | Sets the year of the <a href="#date">Date</a> object using local time.                                                                  |
| **setUTCFullYear**     | (year: number, month?: number \| undefined, date?: number \| undefined) =&gt; number                         | Sets the year value in the <a href="#date">Date</a> object using Universal Coordinated Time (UTC).                                      |
| **toUTCString**        | () =&gt; string                                                                                              | Returns a date converted to a string using Universal Coordinated Time (UTC).                                                            |
| **toISOString**        | () =&gt; string                                                                                              | Returns a date as a string value in ISO format.                                                                                         |
| **toJSON**             | (key?: any) =&gt; string                                                                                     | Used by the JSON.stringify method to enable the transformation of an object's data for JavaScript Object Notation (JSON) serialization. |


#### AnchoredAggregatedQueryOutput

Extended aggregated query output with anchor support.

| Prop         | Type                |
| ------------ | ------------------- |
| **`anchor`** | <code>string</code> |


#### AnchoredAggregatedQueryOptions

Query options for anchored aggregated queries.

| Prop             | Type                                  |
| ---------------- | ------------------------------------- |
| **`sampleName`** | <code>string</code>                   |
| **`startDate`**  | <code>string</code>                   |
| **`endDate`**    | <code><a href="#date">Date</a></code> |
| **`anchor`**     | <code>string</code>                   |

</docgen-api>


## Credits

* Theo Creach (original author) - [Twitter](https://twitter.com/crcht)
* Timothée Bilodeau - [Linkedin](https://www.linkedin.com/in/timoth%E9e-bilodeau-03080ab2/)

## License

This project is licensed under the MIT License
