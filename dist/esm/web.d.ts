import { WebPlugin } from '@capacitor/core';
import type { EditionQuery, AuthorizationQueryOptions, CapacitorHealthkitPlugin, MultipleQueryOptions, SingleQueryOptions, AnchoredQueryOptions, AggregatedQueryOptions, AnchoredAggregatedQueryOptions, QueryOutput, AnchoredQueryOutput, AggregatedQueryOutput, AnchoredAggregatedQueryOutput, MultipleEditionQuery } from './definitions';
export declare class CapacitorHealthkitWeb extends WebPlugin implements CapacitorHealthkitPlugin {
    requestAuthorization(_authOptions: AuthorizationQueryOptions): Promise<void>;
    queryHKitSampleType<T>(_queryOptions: SingleQueryOptions): Promise<QueryOutput<T>>;
    queryHKitSampleTypeAnchored<T>(_queryOptions: AnchoredQueryOptions): Promise<AnchoredQueryOutput<T>>;
    isAvailable(): Promise<{
        available: boolean;
    }>;
    multipleQueryHKitSampleType(_queryOptions: MultipleQueryOptions): Promise<any>;
    isEditionAuthorized(_queryOptions: EditionQuery): Promise<void>;
    multipleIsEditionAuthorized(_queryOptions: MultipleEditionQuery): Promise<void>;
    queryAggregatedDailySampleType(_options: AggregatedQueryOptions): Promise<AggregatedQueryOutput>;
    queryAggregatedDailySampleTypeAnchored(_options: AnchoredAggregatedQueryOptions): Promise<AnchoredAggregatedQueryOutput>;
}
